require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "CODE", "STATE"
    @access_token = "ACCESS_TOKEN"
    @user = users :rubengil
  end

  test "signs in and redirects to root path when authorized" do
    LinkedIn::OauthClient.any_instance.stubs(:access_token).returns(JSON.parse access_token_hash @access_token)
    LinkedIn::Client.any_instance.stubs(:user_info).returns(JSON.parse user_info_hash @user.uid, @user.first_name, @user.last_name, @user.email, @user.access_token, @user.expires_at)
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end
end
