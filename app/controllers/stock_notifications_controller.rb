class StockNotificationsController < ApplicationController
  before_action :authenticate_user!, except: [ :unsubscribe ]

  def create
    product = Product.find(params[:product_id])

    unless product.stock_notifications.exists?(user: current_user)
      product.stock_notifications.create(user: current_user, notified: false)
    end

    redirect_to product_path(product), notice: "You will be notified when the product is back in stock."
  end

  def unsubscribe
    user = User.find_by(id: params[:user_id])
    product = Product.find_by(id: params[:product_id])

    if user && product
      notification = StockNotification.find_by(user: user, product: product)
      if notification
        notification.destroy
        flash[:notice] = "You have been unsubscribed from product notifications."
      else
        flash[:alert] = "Subscription not found."
      end
    else
      flash[:alert] = "Invalid unsubscribe link."
    end

    redirect_to products_path
  end
end
