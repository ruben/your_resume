require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
  end

  test "Retrieves user if exists" do
    @linked_in_client = linked_in_client @user.uid
    assert_equal @user, User.from_linked_in(@linked_in_client)
  end

  test "Creates user and profile if it doesn't exist" do
    @linked_in_client = linked_in_client "new_user_uid", {first_name: "Pepe", summary: "Pepe is very inexperienced"}
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in(@linked_in_client)
      end
    end
  end

  def linked_in_client uid, user_fields = nil
    linked_in_client = LinkedIn::Client.new("ACCESS_TOKEN", "expires_in")
    linked_in_client.expects(:get_user_info).returns(user_info_hash uid)
    if user_fields
      linked_in_client.expects(:get_profile_info).returns(profile_info_hash uid, user_fields)
    end
    linked_in_client
  end
end
