class CategoriesController < ApplicationController

  include CheckRole

  before_action :check_if_can_manage_category, only: [:panel], if: :is_not_webmaster

  def panel
    @categories = Category.all
  end

  protected

  def check_if_can_manage_category
    if !current_user || current_user.role.permission.update_category == false
      flash[:error] = "Vous ne pouvez pas gérer les catégories"
      redirect_to forums_path
    end
  end


end
