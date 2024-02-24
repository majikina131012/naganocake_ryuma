class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
  
  validates :item_id, uniqueness: { scope: :order_id }
  validates :purchase_price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :amount, presence: true, :numericality => { :greater_than_or_equal_to => 1 }
  
  enum making_status:
        {
          impossible_manufacture:0,
          waiting_manufacture:1,
          manufacturing:2,
          finish:3
        }
        
  def subtotal
    purchase_price * amount
  end
end
