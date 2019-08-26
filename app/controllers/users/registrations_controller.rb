# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    super

    if params[:user][:avatar].present?
      response = RestClient.post('https://www.noelshack.com/api.php', :fichier => File.new(params[:user][:avatar].tempfile, 'rb')).body
      if response.include? "www.noelshack.com"
        regex_url = response.split('/')[3].split('-')
        correct_url = "https://image.noelshack.com/fichiers/#{regex_url[0..2].join('/')}/#{regex_url[3..-1].join('-')}"
        @user.update(avatar: correct_url)
      else
        @user.update(avatar: current_user.avatar)
        flash[:error] = "Votre photo de profil n'a pas été mise à jour car elle n'était pas valide"
      end
    end

    if params[:user][:background].present?
      response = RestClient.post('https://www.noelshack.com/api.php', :fichier => File.new(params[:user][:background].tempfile, 'rb')).body
      if response.include? "www.noelshack.com"
        regex_url = response.split('/')[3].split('-')
        correct_url = "https://image.noelshack.com/fichiers/#{regex_url[0..2].join('/')}/#{regex_url[3..-1].join('-')}"
        @user.update(background: correct_url)
      else
        @user.update(background: current_user.background)
        flash[:error] = "Votre photo de couverture n'a pas été mise à jour car elle n'était pas valide"
      end
    end

  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

  def update_resource(resource, params)
    if params[:password]
      resource.password = params[:password]
      resource.password_confirmation = params[:password_confirmation]
    end

    resource.update_without_password(params)
  end

end
