class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]
  
  def index
    @customers = Customer.all
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    @customer.update(customer_params) ? (redirect_to admin_customer_path(@customer)) : (render :edit)
    # このコードは、@customer オブジェクトの更新を試み、更新に成功した場合は指定されたパスにリダイレクトし、更新に失敗した場合は編集画面を再表示するロジックを実装しています。
  end  
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :first_name_kana, :last_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
  
  def ensure_customer
    @customer = Customer.find(params[:id])
  end
  
end
