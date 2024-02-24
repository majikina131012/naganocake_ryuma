class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  # ↑このバリデーションは与えられた文字列が正確に7桁の数字である場合にのみバリデーションを通過させます
  validates :address, presence: true
  validates :name, presence: true
  validates :postage, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  # これは、該当の数値属性が0以上である必要があることを指定しています。つまり、負の値は許可されず、0またはそれよりも大きい値である必要があります。
  validates :billing_amount, presence: true, :numericality => { :greater_than_or_equal_to => 0 }


  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: {wait_payment: 0, confirm_payment: 1, making: 2, preparing_ship: 3, finish_prepare: 4}

  # def get_shipping_informations_from(resource)
  #   class_name = resource.class.name
  #   if class_name == 'Customer' # resource: Customer
  #   # ↑クラス名が 'Customer' であるかを確認しています。つまり、resource が Customer クラスのインスタンスであるかどうかをチェックしています
  #     self.postal_code = resource.postal_code
  #     # ↑resource オブジェクトの postal_code 属性から郵便番号情報を取得し、自身の postal_code 属性に設定します
  #     self.address = resource.address
  #     self.name = resource.full_name

  #   elsif class_name == 'Address' # resource: Address
  #   # ↑もし resource が Address クラスのインスタンスであれば、以下の情報を取得し、自身の属性に設定しています
  #     self.postal_code = resource.postal_code
  #     self.address = resource.address
  #     self.name = resource.name
  #   end
  # end

  def create_order_details(customer)
    unless order_details.first  #最初に、既に注文詳細が存在しない場合（unless order_details.first の条件を満たす場合）、注文詳細を作成します。
      cart_items = customer.cart_items.includes(:item)  #カート内の商品情報を取得します。customer.cart_items.includes(:item) は、指定したユーザー（customer）のカート内の商品情報を取得し、それぞれの商品に関連付けられた商品情報（item）も一緒に読み込みます。
      cart_items.each do |cart_item|
        item = cart_item.item
        OrderDetail.create!(
          order_id: id,
          item_id: item.id,
          purchase_price: item.with_tax_price,
          amount: cart_item.amount
        )
      end
      cart_items.destroy_all  #カート内の商品情報をすべて削除します。cart_items.destroy_all は、カート内のすべての商品情報をデータベースから削除するために使用されています。これにより、注文が確定し、カートが空になります。
    end
  end

  def are_all_details_completed?
    (order_details.completed.count == order_details.count) ? true : false
  end
end
