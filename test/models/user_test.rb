require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @linked_in_client = LinkedIn::Client.new("access_token", "expires_in")
  end

  test "Retrieves user if exists" do
    @linked_in_client.stubs(:user_info).returns(user_info "ruben-uid", "rubengil22@gmail.com")
    assert_equal users(:rubengil), User.from_authorization_info(@linked_in_client)
  end

  test "Creates user and profile if it doesn't exist" do
    @linked_in_client.stubs(:user_info).returns(user_info "newuser-uid", "newuser@gmail.com")
    @linked_in_client.stubs(:profile_info).returns(LinkedIn::ProfileInfo.new("firstName" => "Rubén", "summary" => "Rubén has a lot of experience"))
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_authorization_info(@linked_in_client)
      end
    end
  end
end
