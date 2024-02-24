class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  # before_action :set_cart_item, only: [:create, :update, :destroy]

  def index
    @cart_items = CartItem.all
    # @cart_items = current_customer.cart_items.includes(:item)
  end

  # def create #新しいカートアイテム (cart_item) を作成し、カスタマーID (customer_id) とアイテムID (item_id) を設定します。
  #   cart_item = CartItem.new(cart_item_params)
  #   cart_item.customer_id = current_customer.id
  #   cart_item.item_id = cart_item_params[:item_id]
  #   if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
  #     cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
  #     cart_item.amount += params[:cart_item][:amount].to_i
  #     cart_item.update(amount: cart_item.amount)
  #     redirect_to cart_items_path
  #     #既存のカートアイテムが指定のアイテムIDを持っているかを確認し、存在する場合は数量 (amount) を増やして更新します。
  #   else
  #     cart_item.save
  #     redirect_to cart_items_path
  #     #既存のカートアイテムが存在しない場合、新しいカートアイテムを保存します。
  #   end
  # end

  # def create #最初に @cart_item が存在するかを確認し、存在する場合は数量を更新し、存在しない場合は新しい @cart_item を作成します。
  #   if @cart_item
  #     new_amount = @cart_item.amount + cart_item_params[:amount]
  #     @cart_item.update(amount: new_amount)
  #     redirect_to cart_items_path
  #     # ↑既存のカートアイテムを更新する場合、数量 (amount) を新しい数量 (new_amount) に更新します。
  #   else
  #     @cart_item = current_customer.cart_items.new(cart_item_params)
  #     @cart_item.item_id = @item.id
  #     # ↑新しいカートアイテムを作成する場合、フォームから送信されたデータを使用して新しいカートアイテムを作成します。
  #     if @cart_item.save
  #       redirect_to cart_items_path
  #     else
  #       render 'public/items/show'
  #     end
  #     #カートアイテムが正常に保存された場合、cart_items_path にリダイレクトします。保存に失敗した場合は、商品の詳細ページを再表示します。
  #   end
  # end


  def create
    cart_item = CartItem.new(cart_item_params)
    # cart_item.customer_id = current_customer.id
    cart_item.item_id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save!
      redirect_to cart_items_path
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.destroy if @cart_item
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

  # def set_cart_item
  #   @item = Item.find(params[:item_id])#この行は、リクエストのパラメータから item_id を取得し、それを使用してデータベースからアイテム（Item）を検索しています。Item.find メソッドは、指定された item_id に一致するアイテムをデータベースから取得します。このアイテムは @item インスタンス変数に格納されます。
  #   @cart_item = current_customer.has_in_cart(@item)#この行は、カート内で特定のアイテムが既に存在するかどうかを確認するために、current_customer オブジェクトの has_in_cart メソッドを呼び出しています。has_in_cart メソッドは、カート内で指定されたアイテムを検索し、存在する場合はそれを @cart_item インスタンス変数に格納します。
  # end
  #このメソッドの目的は、リクエストに含まれる item_id を使用して特定のアイテムをデータベースから取得し、そのアイテムがカート内に既に存在するかどうかを確認することです。これにより、カート内のアイテムに関する操作を後続のコードで行う準備が整います。このメソッドをコントローラー内で事前に呼び出すことで、コードの再利用性を高め、効率的な操作を行うことができます。
end
