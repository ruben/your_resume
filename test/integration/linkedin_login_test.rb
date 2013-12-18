require 'test_helper'

class LinkedinLoginTest < ActionDispatch::IntegrationTest
  setup do
    LinkedinAuthorizationController.any_instance.stubs(:oauth_authorize_url).returns("/linkedin_authorization/callback?code=CODE")
    LinkedinAuthorizationController.any_instance.stubs(:oauth_authorize).returns(authorization_info "ruben-uid", "rubengil22@gmail.com")
  end

  test "authenticate user via linkedin" do
    get_via_redirect "/linkedin_authorization/authorize"
    assert_equal '/', path
  end
end