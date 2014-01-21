require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "CODE", "STATE"
    @access_token = "ACCESS_TOKEN"
    @user = users :rubengil
  end

  test "signs in and redirects to root path when authorized" do
    LinkedIn::OauthClient.any_instance.expects(:get_access_token).with(@code).returns(access_token_hash @access_token)
    LinkedIn::Client.any_instance.expects(:get_user_info).with(@access_token).returns(user_info_hash @user.uid)
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end
end
