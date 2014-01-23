require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    @linked_in_client = LinkedIn::Client.new("ACCESS_TOKEN", "expires_in")
  end

  test "Retrieves user if exists" do
    @linked_in_client.expects(:get_user_info).returns(user_info_hash @user.uid, @user.first_name, @user.last_name, @user.email)
    assert_equal @user, User.from_linked_in(@linked_in_client)
  end

  test "Creates user and profile if it doesn't exist" do
    @linked_in_client.expects(:get_user_info).returns(user_info_hash "new_user_uid", "Pepe", "Viyuela", "pepe@gmail.com")
    @linked_in_client.expects(:get_profile_info).returns(profile_info_hash "new_user_uid", "Pepe","Pepe is very inexperienced")
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in(@linked_in_client)
      end
    end
  end
end
