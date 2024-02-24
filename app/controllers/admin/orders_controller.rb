class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_order, only: [:show, :update]
  
  def index
  end  
  
  def show
    @order_details = OrderDetail.where(order_id: params[:id])
    # ↑このコードは、OrderDetail モデルから order_id が指定された params[:id] と一致する注文の詳細情報を取得しようとしています。
    @customer = @order.customer
    # @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
      @order_details.update_all(making_status: :waiting_manufacture) if @order.status == "confirm_payment"
    end
    redirect_to admin_order_path(@order.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:status)
  end
  
  def ensure_order
    @order = Order.find(params[:id])
  end  
end
