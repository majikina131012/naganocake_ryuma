class Item < ApplicationRecord
  has_one_attached :item_image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price_without_tax, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  def with_tax_price
   (price_without_tax * 1.1).floor
   # ceilは切り上げ、floorが切り捨て、roundが四捨五入
  end
  
  
  def get_item_image(width, height)
    unless item_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      item_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    item_image.variant(resize_to_limit: [width, height]).processed
  end
end
