require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
  end

  test "Retrieves user if exists" do
    stub_get_user_info @user.access_token, @user
    @client = LinkedIn::Client.new(@user.access_token, "expires_in")
    assert_equal @user, User.from_linked_in(@client)
  end

  test "Creates user and profile if it doesn't exist" do
    stub_get_user_info "new_user_access_token", User.new(uid: "new_user_uid", first_name: "Pepe", last_name: "Viyuela", email: "pepe@gmail.com", access_token: "new_user_token", expires_at: "new_user_expiration")
    stub_get_profile_info "new_user_access_token", Profile.new(first_name: "Pepe", summary: "Pepe is very inexperienced")
    @client = LinkedIn::Client.new("new_user_access_token", "expires_in")
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in(@client)
      end
    end
  end


end
