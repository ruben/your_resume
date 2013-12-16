require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    LinkedIn::OauthClient.expects(:authorize).returns authorization_info("ruben-uid", "rubengil22@gmail.com")
  end

  test "callback gets user info" do
    get :callback, code: @code, state: @state
    assert_equal authorization_info("ruben-uid", "rubengil22@gmail.com"), assigns[:authorization_info]
  end
end
