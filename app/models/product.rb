class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_rich_text :description
  has_many :stock_notifications
  has_many :subscribers, through: :stock_notifications, source: :user

  def in_stock?
  available_stock.to_i > 0
  end
end
