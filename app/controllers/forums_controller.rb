class ForumsController < ApplicationController

  include CheckRole

  before_action :check_if_can_manage_forum, only: [:panel], if: :is_not_webmaster

  def index
    @categories = Category.all
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

end
