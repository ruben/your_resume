require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code = "AUTHORIZATION_CODE"
    @state = "STATE"
    @authorization_info = {user_info: {uid: "UUID", email: "rubengil22@gmail.com"}, access_token: {expires_in: 12345, access_token: "ACCESS_TOKEN"}}
    flexmock(LinkedIn::OauthClient).should_receive(:authorize).with(@code).
        and_return(@authorization_info)

  end

  test "callback gets user info" do
    get :callback, code: @code, state: @state
    assert_equal(@authorization_info , assigns[:authorization_info])
  end
end
