# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_customer, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    # ユーザーが提供したメールアドレスを使用して、データベース内のユーザー（Customer）を検索し、その結果を @customer 変数に格納します。これにより、提供されたメールアドレスに一致するユーザーを取得できます。
      if @customer
        if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
          # ↑この条件文は、ユーザーが提供したパスワードが正しいかつユーザーが退会状態にある場合に実行されます。valid_password? メソッドは、提供されたパスワードが正しいかどうかを確認します。また、is_deleted 属性はユーザーが退会しているかどうかを示し、この属性が true の場合、ユーザーは退会状態にあることを意味します。
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_customer_registration_path
        end
      end
  end
  # ↑退会した者のログインを弾く機能

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
