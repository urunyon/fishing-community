require "test_helper"

class Admin::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get public::search" do
    get admin_search_public::search_url
    assert_response :success
  end
end
