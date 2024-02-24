class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :item_id, uniqueness: { scope: :customer_id }
  # このルールは、item_id フィールドが一意であることを検証しています。つまり、同じ customer_id の顧客が同じ item_id の商品を複数回カートに入れることができないようにします。scope: :customer_id の指定により、customer_id が同じ場合に item_id が一意である必要があります。
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  #   このルールは、amount フィールドに対して複数の検証条件を設定しています。
  # presence: true は、amount フィールドが必須であることを検証しています。つまり、カートアイテムを作成または更新する際に amount フィールドは空であってはいけません。
  # numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 } は、amount フィールドが数値であり、かつ1以上10以下であることを検証しています。つまり、カートに入れる商品の数量は1から10までの範囲内でなければなりません。

  def subtotal
    item.with_tax_price * amount
  end

end
