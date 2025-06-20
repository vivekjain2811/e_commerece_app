class CreateStockNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.boolean :notified

      t.timestamps
    end
  end
end
