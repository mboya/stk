require 'test_helper'

class PushControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get push_index_url
    assert_response :success
  end

end
