require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "code", "state"
  end

  test "callback retrieves user if it exists" do
    LinkedIn::OauthClient.expects(:authorize).returns authorization_info("ruben-uid", "rubengil22@gmail.com")
    get :callback, code: @code, state: @state
    assert_equal users(:rubengil), assigns(:user)
  end

  test "callback creates user if it doesn't exist" do
    LinkedIn::OauthClient.expects(:authorize).returns authorization_info("newuser-uid", "newuser@gmail.com")
    assert_difference "User.count" do
      get :callback, code: @code, state: @state
      assert_not_nil assigns :user
    end
  end
end
