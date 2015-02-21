class CreateOrders < ActiveRecord::Migration
  def change
  	create_table :orders do |t|
      t.string :order_no
      t.integer :customer_id
      t.decimal :total, precision: 9, scale: 1
      t.date :date

      t.timestamps null: false
     end
     add_index :orders, :customer_id
  end
end
