class UsersController < ApplicationController

  def show
    @user = User.where('lower(username) = ?', params[:username].downcase).first 
    raise ActionController::RoutingError.new('Not Found') if @user.blank?
  end

end