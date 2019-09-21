class StaffController < ApplicationController
  before_action :find_user_on_demote, only: [:demote, :can_demote_role]
  before_action :find_user_on_promote, only: [:promote, :can_promote_role]
  before_action :find_role_on_promote, only: [:promote, :can_promote_role]
  before_action :find_role_on_new, only: [:new, :create, :build_nested_permission]
  before_action :find_role_on_edit, only: [:edit, :update, :build_nested_permission]
  before_action :build_nested_permission, only: [:new, :create, :edit, :update]

  before_action :can_manage_role, only: [:roles], if: :is_not_webmaster
  before_action :can_create_role, only: [:new, :create], if: :is_not_webmaster
  before_action :can_update_role, only: [:edit, :update], if: :is_not_webmaster
  before_action :can_promote_role, only: [:promote], if: :is_not_webmaster
  before_action :can_demote_role, only: [:demote], if: :is_not_webmaster

  def index
    @user = User.new
    @roles = Role.joins(:permission).all.where.not(id: 1).order(priority_permission: :desc)
  end

  def new
  end

  def create
    @role.assign_attributes(role_params)
    if @role.save
      flash[:success] = "Le rôle a été créé avec succès !"
      redirect_to staff_index_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update_attributes(role_params)
      flash[:success] = "Le rôle a été modifié avec succès !"
      redirect_to roles_staff_index_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :edit
    end
  end

  def roles
    @roles = Role.joins(:permission).all.order(priority_permission: :desc)
  end

  def promote
    if @user.promote(params[:user][:role_id])
      flash[:success] = "Le membre a été promu avec succès !"
      redirect_to staff_index_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :index
    end
  end

  def demote
    if @user.demote
      flash[:success] = "Le membre a été rétrogradé avec succès !"
      redirect_to staff_index_path
    end
  end

  protected

  def is_not_webmaster
    current_user.role.permission.priority_permission != 100
  end

  def can_manage_role
    if !current_user || current_user.role.permission.update_role == false
      flash[:error] = "Vous ne pouvez pas gérer de rôle"
      redirect_to staff_index_path
    end
  end

  def can_create_role
    if !current_user || current_user.role.permission.create_staff == false
      flash[:error] = "Vous ne pouvez pas créer de rôle"
      redirect_to staff_index_path
    end
  end

  def can_update_role
    if !current_user || current_user.role.permission.update_role == false
      flash[:error] = "Vous ne pouvez pas modifier de rôle"
      redirect_to roles_staff_index_path
    elsif current_user.role == @role
      flash[:error] = "Vous ne pouvez pas modifier votre rôle"
      redirect_to roles_staff_index_path
    elsif current_user.role.permission.priority_permission < @role.permission.priority_permission
      flash[:error] = "Vous ne pouvez pas modifier un rôle qui est supérieur au votre"
      redirect_to roles_staff_index_path
    end
  end

  def can_promote_role
    if params[:user][:id] == "" || params[:user][:role_id] == ""
      flash[:error] = "Vous devez sélectionner un membre et un rôle pour promouvoir quelqu'un"
      redirect_to staff_index_path
    elsif !current_user || current_user.role.permission.promote_user == false
      flash[:error] = "Vous ne pouvez pas promouvoir d'utilisateur"
      redirect_to staff_index_path
    elsif current_user.role.permission.priority_permission < @user.role.permission.priority_permission
      flash[:error] = "Vous ne pouvez pas promouvoir cet utilisateur car il a un rôle supérieur au votre"
      redirect_to staff_index_path
    elsif current_user.role.permission.priority_permission < @role.permission.priority_permission
      flash[:error] = "Vous ne pouvez pas promouvoir un utilisateur à un rôle supérieur au votre"
       redirect_to staff_index_path
    end
  end

  def can_demote_role
    if !current_user || current_user.role.permission.demote_user == false
      flash[:error] = "Vous ne pouvez pas rétrograder d'utilisateur"
      redirect_to staff_index_path
    elsif current_user.role.permission.priority_permission < @user.role.permission.priority_permission
      flash[:error] = "Vous ne pouvez pas rétrograder cet utilisateur car il a un rôle supérieur au votre"
      redirect_to staff_index_path
    end
  end

  private

  def find_user_on_demote
    @user = User.find(params[:id])
  end

  def find_user_on_promote
    @user = User.find(params[:user][:id]) if params[:user][:id] != ""
  end

  def find_role_on_promote
    @role = Role.find(params[:user][:role_id]) if params[:user][:role_id] != ""
  end

  def find_role_on_edit
    @role = Role.find(params[:id])
  end

  def find_role_on_new
    @role = Role.new
  end

  def build_nested_permission
    @role.build_permission if @role.permission.nil?
  end

  def role_params
    params.require(:role).permit(:label, 
                                 :color,
                                 :icon,
                                 permission_attributes: [:id,
                                                         :create_article,
                                                         :update_article,
                                                         :delete_article,
                                                         :undelete_article,
                                                         :kill_article,
                                                         :lock_topic,
                                                         :unlock_topic,
                                                         :delete_topic,
                                                         :undelete_topic,
                                                         :kill_topic,
                                                         :pin_topic,
                                                         :unpin_topic,
                                                         :delete_message,
                                                         :undelete_message,
                                                         :kill_message,
                                                         :kick_user,
                                                         :unkick_user,
                                                         :ban_user,
                                                         :unban_user,
                                                         :banip_user,
                                                         :unbanip_user,
                                                         :kill_user,
                                                         :create_forum,
                                                         :update_forum,
                                                         :delete_forum,
                                                         :undelete_forum,
                                                         :kill_forum,
                                                         :create_staff,
                                                         :update_role,
                                                         :delete_role,
                                                         :undelete_role,
                                                         :kill_role,
                                                         :update_permission,
                                                         :priority_permission,
                                                         :create_topic,
                                                         :update_topic,
                                                         :create_message,
                                                         :update_message,
                                                         :update_user,
                                                         :promote_user,
                                                         :demote_user
      ]
    )
  end

  
end
