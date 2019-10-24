# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  #POST /resource
  def create
    super 
    atrium_user = create_atrium_user
    current_user.update_attribute(:guid, atrium_user.guid)
  end
<<<<<<< HEAD

=======
>>>>>>> 127d636b937b02bf7cd1e8f16de7ec2ea99b6a8b

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

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

<<<<<<< HEAD
  protected
=======
protected
>>>>>>> 127d636b937b02bf7cd1e8f16de7ec2ea99b6a8b
  def create_atrium_user
    user_info = {:user => {:identifier => SecureRandom.uuid}}
    body = Atrium::UserCreateRequestBody.new(userInfo) 
    atrium_user = client.users.create_user(body)
    atrium_user&.user
  rescue Atrium::ApiError => e
    Rails.logger.info "Exception when calling UsersApi->create_user: #{e}"
  end 

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
end
