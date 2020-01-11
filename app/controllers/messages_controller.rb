class MessagesController < ApplicationController

    include CheckRole
    before_action :find_forum_by_id, only: [:new, :create, :show, :check_if_can_create_message]
    before_action :find_topic_by_id, only: [new, :create, :show, :check_if_can_create_message]
    before_action :find_message_on_new, only: [:new, :create]
    before_action :find_message_by_id, only: [:show]
  
    before_action :check_if_can_create_message, only: [:new, :create], if: :is_not_webmaster
  
    def new
    end
  
    def create
      @message.assign_attributes(message_params)
      if @message.save
        flash[:success] = "Le message a été créé avec succès !"
        redirect_to forum_topic_path(@forum, @topic)
      else
        flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
        render :new
      end
    end
  
    protected
  
    def check_if_can_create_message
      if !current_user
        flash[:error] = "Vous devez être connecté pour répondre à un sujet"
        redirect_to forum_topic_path(@forum, @topic)
      end
    end
  
    private
  
    def find_message_on_new
      @message = @topic.messages.new
    end
  
    def find_topic_by_id
      @topic = Topic.find_by_id(params[:topic_id])
    end
  
    def find_forum_by_id
      @forum = Forum.find_by_id(params[:forum_id])
    end

    def find_message_by_id
      @message = Message.find_by_id(params[:id])
    end
  
    def message_params
      params.require(:message).permit(:content)
    end
  
  end
  