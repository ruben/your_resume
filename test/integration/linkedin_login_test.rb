require 'test_helper'

class LinkedinLoginTest < ActionDispatch::IntegrationTest
  setup do
    LinkedinAuthorizationController.any_instance.stubs(:oauth_authorize_url).returns("/linkedin_authorization/callback?code=CODE")
    linked_in_client = LinkedIn::Client.new "access_info"
    linked_in_client.stubs(:authorization_info).returns authorization_info("ruben-uid", "rubengil22@gmail.com")
    LinkedinAuthorizationController.any_instance.stubs(:linked_in_client).returns(linked_in_client)
  end

  test "authenticate user via linkedin" do
    get_via_redirect "/linkedin_authorization/authorize"
    assert_equal '/', path
  end
end