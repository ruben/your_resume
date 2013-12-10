require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  class LinkedIn::AuthorizationUrl
    def to_s
      "http://autorization_site"
    end
  end

  test "new session redirects to get oauth token" do
    get :new
    assert_redirected_to LinkedIn::AuthorizationUrl.new.to_s
  end
end
