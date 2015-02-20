class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, precision: 9, scale: 1
      t.boolean :status
      t.text :description

      t.timestamps null: false
    end
  end
end
