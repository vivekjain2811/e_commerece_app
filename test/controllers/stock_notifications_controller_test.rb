require "test_helper"

class StockNotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get stock_notifications_create_url
    assert_response :success
  end
end
