class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index first show]

  def index
    @products = Product.all
  end

  def first
  @product = Product.first
  end
  def show
  end

  def new
    @product = current_user.products.build
  end

  def create
    @product = current_user.products.build(product_params)
    if @product.save
      redirect_to @product, notice: "Product was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)

      if @product.available_stock == 0
        @product.stock_notifications.update_all(notified: false)
      end


      if @product.available_stock > 0
        @product.stock_notifications.where(notified: false).find_each do |notification|
          StockNotifierMailer.back_in_stock(notification.user, @product).deliver_later
          notification.update(notified: true)
        end
      end

      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: "Product was successfully deleted."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:product_name, :product_price, :available_stock, :description, :image)
  end
end
