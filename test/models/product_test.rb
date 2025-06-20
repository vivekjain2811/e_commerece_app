require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one) # Load fixture
  end

  test "product is valid" do
    assert @product.valid?
  end

  test "product is in stock" do
    assert @product.in_stock?
  end
end
