class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    
    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(status: 2) if @order_detail.making_status == "manufacturing"  #もし注文詳細の making_status が "manufacturing" の場合、注文のステータスを 2 (制作中) に変更します。
      @order_details.each do |order_detail|
        if order_detail.making_status != "finish"  #各注文詳細の making_status が "finish" でない場合、is_updated フラグを false に設定します。
          is_updated = false 
        end
      end
      @order.update(status: 3) if is_updated  #もしすべての注文詳細が "finish" ステータスである場合（is_updated が true のままである場合）、注文のステータスを 3 (出荷準備中) に変更します。
    end
    redirect_to admin_order_path(@order)
  end
  

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
