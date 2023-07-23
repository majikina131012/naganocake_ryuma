class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.timestamps
      t.integer :order_id, null: false
      t.integer :item_id, null: false
      t.integer :purchase_price, null: false
      t.integer :making_status, null: false, default: 0
      t.integer :amount, null: false
    end
  end
end
