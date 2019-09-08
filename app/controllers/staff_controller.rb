class StaffController < ApplicationController
  before_action :check_permission, only: [:new, :create]

  def index
    @roles = Role.joins(:permission).all.where.not(id: 1).order(priority_permission: :desc)
  end

  def new
    @role = Role.new
    @role.build_permission
  end

  def create
    @role = Role.new(role_params)
    @role.build_permission
    if @role.save
      flash[:success] = "ok"
      redirect_to staff_index_path
    else
      flash[:error] = "pas ok"
      render :new
    end

  end

  protected

  def check_permission
    raise ActionController::RoutingError.new('Not Found') if !current_user || current_user.role.permission.update_permission == false
  end

  private

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
                                                         :priority_permission
      ]
    )
  end
  
end
