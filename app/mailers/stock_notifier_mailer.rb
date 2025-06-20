class StockNotifierMailer < ApplicationMailer
  def back_in_stock(user, product)
    @user = user
    @product = product
    @unsubscribe_url = unsubscribe_stock_notifications_url(user_id: user.id, product_id: product.id)

    mail(
      to: @user.email,
      subject: "#{product.product_name} is back in stock!"
    )
  end
end
