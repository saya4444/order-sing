class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthdate, :vocal_range_id, :profile, :image, :direct_messages_enabled])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birthdate, :vocal_range_id, :profile, :image, :direct_messages_enabled])
  end
end
