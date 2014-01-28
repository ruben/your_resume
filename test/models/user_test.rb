require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    @client = stub_linked_in_client "ruben", "new_ruben_access_token"
  end

  test "Retrieves user if exists" do
    assert_equal @user.uid, User.from_linked_in(@client).uid
  end

  test "Updates access token" do
    updated_user = User.from_linked_in @client
    assert_not_equal @user.access_token, updated_user.access_token
  end

  test "Creates user and profile" do
    @user.destroy
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in @client
      end
    end
  end
end
