class ForumsController < ApplicationController

  include CheckRole

  before_action :find_forum_on_new, only: [:new, :create]
  before_action :find_forum_by_id, only: [:edit, :update, :show]

  before_action :check_if_can_manage_forum, only: [:panel], if: :is_not_webmaster
  before_action :check_if_can_create_forum, only: [:new, :create], if: :is_not_webmaster
  before_action :check_if_can_update_forum, only: [:edit, :update], if: :is_not_webmaster

  def index
    @categories = Category.all
  end

  def new
  end

  def create
    @forum.assign_attributes(forum_params)
    if @forum.save
      flash[:success] = "Le forum a été créé avec succès !"
      redirect_to panel_forums_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :new
    end
  end

  def edit
  end

  def update
    if @forum.update_attributes(forum_params)
      flash[:success] = "Le forum a été modifié avec succès !"
      redirect_to panel_forums_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :edit
    end
  end

  def show
    @topics = @forum.topics.order(last_message: :desc).paginate(page: params[:page], per_page: 2)
    @topic = Topic.new
    @topic.messages.build
  end

  def panel
    @forums = Forum.all
  end

  protected

  def check_if_can_manage_forum
    if !current_user || current_user.role.permission.update_forum== false
      flash[:error] = "Vous ne pouvez pas gérer les forums"
      redirect_to forums_path
    end
  end

  def check_if_can_create_forum
    if !current_user || current_user.role.permission.create_forum == false
      flash[:error] = "Vous ne pouvez pas créer de forum"
      redirect_to forums_path
    end
  end

  def check_if_can_update_forum
    if !current_user || current_user.role.permission.update_forum == false
      flash[:error] = "Vous ne pouvez pas modifier de forum"
      redirect_to forums_path
    elsif current_user.role.permission.priority_permission < @forum.role.permission.priority_permission
      flash[:error] = "Vous ne pouvez pas modifier un forum qui a un rôle supérieur au votre"
      redirect_to panel_forums_path
    end
  end

  private

  def find_forum_on_new
    @forum = Forum.new
  end

  def find_forum_by_id
    @forum = Forum.find_by_id(params[:id])
  end

  def find_topics_by_forum
    @forum = Forum.find_by_id(params[:id])
    @topics = @forum.topics
  end

  def forum_params
    params.require(:forum).permit(:name, 
                                  :description, 
                                  :category_id,
                                  :role_id)
  end

end
