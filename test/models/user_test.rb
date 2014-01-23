require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    stub_linked_in_client
  end

  test "Retrieves user if exists" do
    @client = LinkedIn::Client.new(@user.access_token, "expires_in")
    assert_equal @user, User.from_linked_in(@client)
  end

  test "Creates user and profile if it doesn't exist" do
    @client = LinkedIn::Client.new("new_user_access_token", "expires_in")
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in(@client)
      end
    end
  end


end
