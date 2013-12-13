require 'test_helper'

class LinkedinAuthenticationControllerTest < ActionController::TestCase
  setup do
    @code = "AUTHORIZATION_CODE"
    @state = "STATE"
    @access_token = "ACCESS_TOKEN"
    flexmock(LinkedIn::OauthClient).should_receive(:authorize).with(@code).
        and_return(uid: "UUID", email: "rubengil22@gmail.com")

  end

  test "callback gets user info" do
    get :callback, code: @code, state: @state
    assert_equal({uid: "UUID", email: "rubengil22@gmail.com"}, assigns[:user_info])
  end
end
