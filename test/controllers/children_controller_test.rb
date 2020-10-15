require 'test_helper'

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get children_new_url
    assert_response :success
  end

end
