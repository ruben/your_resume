require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "CODE", "STATE"
    @access_token = "ACCESS_TOKEN"
  end

  test "signs in and redirects to root path when authorized" do
    LinkedIn::OauthClient.any_instance.expects(:get_access_token).with(@code).returns('{"expires_in":5184000, "access_token": "ACCESS_TOKEN"}')
    LinkedIn::Client.any_instance.expects(:get_user_info).with(@access_token).returns('{"id": "ruben-uid", "firstName": "Rubén", "lastName": "Gil", "emailAddress": "rubengil22@gmail.com"}')
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end
end
