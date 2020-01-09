class CategoriesController < ApplicationController

  include CheckRole

  before_action :find_category_on_new, only: [:new, :create]
  before_action :find_category_on_edit, only: [:edit, :update]

  before_action :check_if_can_manage_category, only: [:panel], if: :is_not_webmaster
  before_action :check_if_can_create_category, only: [:new, :create], if: :is_not_webmaster
  before_action :check_if_can_update_category, only: [:edit, :update], if: :is_not_webmaster

  def new
  end

  def create
    @category.assign_attributes(category_params)
    if @category.save
      flash[:success] = "La catégorie a été créée avec succès !"
      redirect_to panel_categories_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      flash[:success] = "La catégorie a été modifiée avec succès !"
      redirect_to panel_categories_path
    else
      flash.now[:error] = "Veuillez résoudre les erreurs ci-dessous"
      render :edit
    end
  end

  def panel
    @categories = Category.all
  end

  protected

  def check_if_can_manage_category
    if !current_user || current_user.role.permission.update_category == false
      flash[:error] = "Vous ne pouvez pas gérer les catégories"
      redirect_to categories_path
    end
  end

  def check_if_can_create_category
    if !current_user || current_user.role.permission.create_category == false
      flash[:error] = "Vous ne pouvez pas créer de catégorie"
      redirect_to categories_path
    end
  end

  def check_if_can_update_category
    if !current_user || current_user.role.permission.update_category == false
      flash[:error] = "Vous ne pouvez pas modifier de catégorie"
      redirect_to categories_path
    end
  end

  private

  def find_category_on_new
    @category = Category.new
  end

  def find_category_on_edit
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, 
                                  :description, 
                                  :icon)
  end

end
