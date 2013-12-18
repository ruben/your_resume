require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "code", "state"
  end

  test "signs in and redirects to root path when authorized" do
    LinkedIn::OauthClient.expects(:authorize).returns authorization_info("ruben-uid", "rubengil22@gmail.com")
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to linkedin_new_session_path
  end
end
