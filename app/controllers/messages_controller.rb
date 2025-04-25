class MessagesController < ApplicationController
  include CheckRole
  include BbcoderService

  skip_before_action :verify_authenticity_token, only: [:preview, :quote]
  before_action :find_forum_by_id, only: [:new, :create, :show]
  before_action :find_topic_by_id, only: [:new, :create, :show]
  before_action :find_message_on_new, only: [:new, :create]
  before_action :find_message_by_id, only: [:show]
  before_action :find_last_page, only: [:create]
  before_action :check_if_can_create_message, only: [:new, :create], if: :is_not_webmaster

  def new
  end

  def show
  end

  def create
    @message.assign_attributes(message_params)
    if @message.save
      flash[:success] = "Le message a été créé avec succès !"
      redirect_to forum_topic_path(@forum, @topic, page: @last_page) + "##{@message.id}"
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :new
    end
  end

  def preview
    bbcode_to_html = params[:content].bbcode_to_html.gsub(/\n/, '<br/>').html_safe if params[:content]
    render inline: params[:content].present? ? bbcode_to_html : ""
  end

  def quote
    quote = params[:content].to_i if params[:content]
    message = Message.find_by(id: quote)
    quote_message = BbcoderService.quote_message(message)
    render inline: message.present? ? quote_message : ""
  end

  protected

  def check_if_can_create_message
    unless current_user
      flash[:error] = "Vous devez être connecté pour répondre à un sujet"
      redirect_to forum_topic_path(@forum, @topic)
    end
  end

  private

  def find_message_on_new
    @message = @topic.messages.new
  end

  def find_topic_by_id
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def find_forum_by_id
    @forum = Forum.find_by(id: params[:forum_id])
  end

  def find_message_by_id
    @message = Message.find_by(id: params[:id])
  end

  def find_last_page
    @last_page = (@topic.messages.count / 20) + 1
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
