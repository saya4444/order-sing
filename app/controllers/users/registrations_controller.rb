# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]


  protected

  #新規登録用ストロングパラメータ
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :birthdate, :vocal_range_id, :profile, :image])
  end

  #編集用ストロングパラメータ
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :birthdate, :vocal_range_id, :profile, :image])
  end


end
