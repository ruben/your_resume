require 'test_helper'

class LinkedinAuthorizationControllerTest < ActionController::TestCase
  setup do
    @code, @state = "code", "state"
  end

  test "signs in and redirects to root path when authorized" do
    linked_in_client = LinkedIn::Client.new "access_info"
    linked_in_client.stubs(:user_info).returns user_info("ruben-uid", "rubengil22@gmail.com")
    LinkedinAuthorizationController.any_instance.stubs(:linked_in_client).returns(linked_in_client)
    get :callback, code: @code, state: @state
    assert warden.authenticated?(:user)
    assert_redirected_to root_path
  end

  test "redirects to sign in path when not authorized" do
    get :callback, error: 'access_denied', error_description: 'the user denied your request', state: @state
    assert_redirected_to new_user_session_path
  end
end
