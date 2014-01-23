require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "CODE", "STATE"
    @user = users :rubengil
    stub_linked_in_client
  end

  test "signs in and redirects to root path when authorized" do
    LinkedIn::OauthClient.any_instance.stubs(:access_token).returns(JSON.parse access_token_hash @user.access_token)
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end
end
