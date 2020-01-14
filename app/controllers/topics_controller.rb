class TopicsController < ApplicationController

  include CheckRole
  include BbcoderService

  before_action :find_forum_by_id, only: [:new, :create, :show]
  before_action :find_topic_on_new, only: [:new, :create]
  before_action :find_topic_by_id, only: [:show]

  before_action :check_if_can_create_topic, only: [:new, :create], if: :is_not_webmaster

  def new
  end

  def create
    @topic.assign_attributes(topic_params)
    if @topic.save
      flash[:success] = "Le topic a été créé avec succès !"
      redirect_to forum_path(@forum)
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :new
    end
  end

  def show
    @messages = @topic.messages.order(created_at: :asc).paginate(page: params[:page], per_page: 20)
    @message = Message.new
  end

  def quote
    @quote_to_bbcode = params[:quote].bbcode_to_html.gsub(/\n/, '<br/>').html_safe if params[:content]
    render inline: !params[:quote].blank? ? "" : "" 
  end

  protected

  def check_if_can_create_topic
    if !current_user
      flash[:error] = "Vous devez être connecté pour poster un sujet"
      redirect_to forum_path(@forum)
    end
  end

  private

  def find_topic_on_new
    @topic = @forum.topics.new
  end

  def find_topic_by_id
    @topic = Topic.find_by_id(params[:id])
  end

  def find_forum_by_id
    @forum = Forum.find_by_id(params[:forum_id])
  end

  def topic_params
    params.require(:topic).permit(:title, messages_attributes: [:id, :content])
  end

end
