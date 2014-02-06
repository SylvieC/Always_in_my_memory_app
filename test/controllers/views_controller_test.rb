require 'test_helper'

class ViewsControllerTest < ActionController::TestCase
  test "should get value:integer" do
    get :value:integer
    assert_response :success
  end

end
