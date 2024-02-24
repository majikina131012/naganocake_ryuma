# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def after_sign_up_path_for(resource)
    mypage_path
  end

  def after_update_path_for(resource)
    mypage_path
  end
   # ↑プロフィールの更新後にリダイレクトさせたい場所を指定する


  # protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number])
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
