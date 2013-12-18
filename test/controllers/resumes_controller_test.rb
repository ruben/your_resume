require 'test_helper'

class ResumesControllerTest < ActionController::TestCase
  test "should get show" do
    sign_in(users :rubengil)
    get :show
    assert_response :success
  end
end
