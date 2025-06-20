class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.decimal :product_price
      t.integer :available_stock

      t.timestamps
    end
  end
end
