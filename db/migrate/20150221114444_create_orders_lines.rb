class CreateOrdersLines < ActiveRecord::Migration
  def change
  	create_table :order_lines do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :qty
      t.decimal :unit_price, precision: 9, scale: 1
      t.decimal :total_price, precision: 9, scale: 1

      t.timestamps null: false
    end
  end

end
