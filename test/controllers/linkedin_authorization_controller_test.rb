require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "CODE", "STATE"
    @user = users :rubengil
  end

  test "signs in and redirects to root path when authorized" do
    stub_get_access_token @code, @user.access_token
    stub_get_user_info @user.access_token, @user
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end

  def stub_get_access_token authorization_code, access_token
    LinkedIn::OauthClient.any_instance.stubs(:get_access_token).with(authorization_code).returns(access_token_hash access_token)
  end


end
