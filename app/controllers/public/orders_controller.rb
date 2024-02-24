class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create, :error]

  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end

  def confirm
    @order = Order.new(order_params)
    @order.postage = 800
    if params[:order][:select_address] == "0"

      # @order.get_shipping_informations_from(current_customer)

      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
      @selected_address = current_customer.addresses.find(params[:order][:address_id])

      # @order.get_shipping_informations_from(@selected_address)


      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:select_address] == "2" && (@order.postal_code =~ /\A\d{7}\z/) && @order.address? && @order.name?
      # 処理なし
#       ↑ユーザーが "新しいお届け先" を選択し、かつ郵便番号が7桁の数字であり、かつ @order オブジェクトの属性 address と name が設定されている場合。
# 条件が成り立つ場合、この条件に合致する特定の処理（おそらく何もしないこと）が実行される

      # @order.customer_id = current_customer.id

    else
      flash[:notice] = '情報を正しく入力して下さい。'
      render :new
    end
  end

  def index
    @orders = current_customer.orders

  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = @order.order_details
    # @order_details = OrderDetail.where(order_id: params[:id])
    # @order = Order.find(params[:id])
  end

  def error
  end

  def create
    @order = current_customer.orders.new(order_params)
    # customer_id = current_customer.idが入力されている
    @order.postage = 800
    @order.billing_amount = @order.postage + @cart_items.sum(&:subtotal)

      if @order.save
        @order.create_order_details(current_customer)
        redirect_to orders_thanks_path
      else
        render :new
      end

  end



  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items
    redirect_to items_path if @cart_items.empty?
  end
# ↑このコードの目的は、ユーザーがカートにアイテムを追加する前に、カート内に少なくとも1つのアイテムが存在することを確認することです。カートが空の場合、ユーザーを商品一覧ページにリダイレクトすることで、カートに商品を追加する前に商品を選択するよう促します。

end
