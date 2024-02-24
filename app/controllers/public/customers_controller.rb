class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_current_customer
  
  def show
  end
  
  def edit
  end  
  
  def update
    if @customer.update(customer_params)
      redirect_to mypage_path, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
    # customer = Customer.find(params[:id])
    # customer.update(customer_params)
    # redirect_to customer_path(current_customer)
  end
  
  def check
  end  
  
  def withdraw
    # @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
     # reset_session メソッドは、セッション内のすべてのデータを削除し、新しいセッションを作成する役割を果たします。これは、ユーザーがログアウトした際や、セッション情報が不要になった場合に使用されます。セッションをクリアすることで、ユーザーの一時的なデータや認証情報が削除され、セキュリティを向上させるのに役立ちます。
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end  
  
  private
  
  def set_current_customer
    @customer = current_customer
  end
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number)
  end  
end
