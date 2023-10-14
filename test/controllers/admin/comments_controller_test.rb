require "test_helper"

class Admin::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get public/comments" do
    get admin_comments_public/comments_url
    assert_response :success
  end
end
