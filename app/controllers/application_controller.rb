class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_last_seen_at 
  before_action :get_users_logged_in
  before_action :configure_permitted_parameters, if: :devise_controller?

  def get_users_logged_in
    @users_online = User.where('last_seen_at > ?', 5.minutes.ago) 
  end

  protected
  
  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    updated_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :birthdate, :description, :avatar, :music, :background, :country, :gender]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: updated_attrs
  end

  private

  def set_last_seen_at
    current_user.update_attribute(:last_seen_at, Time.now) if current_user
  end

end
