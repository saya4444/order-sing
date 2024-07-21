class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthdate, :vocal_range_id, :profile, :image])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birthdate, :vocal_range_id, :profile, :image])
  end

  def update
    resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    if account_update_params[:password].blank? && account_update_params[:password_confirmation].blank?
      account_update_params.delete(:password)
      account_update_params.delete(:password_confirmation)
    end

    if resource.update_without_password(account_update_params)
      set_flash_message :notice, :updated
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      respond_with resource
    end
  end
end
