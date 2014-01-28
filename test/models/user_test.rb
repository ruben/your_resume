require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
  end

  test "Retrieves user if exists" do
    stub_get_user_info "ruben"
    @client = LinkedIn::Client.new("new_ruben_access_token", "expires_in")
    assert_equal @user.uid, User.from_linked_in(@client).uid
  end

  test "Updates access token" do
    stub_get_user_info "ruben"
    @client = LinkedIn::Client.new("new_ruben_access_token", "expires_in")
    updated_user = User.from_linked_in(@client)
    assert_not_equal @user.access_token, updated_user.access_token
  end

  test "Creates user and profile" do
    @user.destroy
    stub_get_user_info "ruben"
    stub_get_profile_info "ruben"
    @client = LinkedIn::Client.new("new_ruben_access_token", "expires_in")
    assert_difference "User.count" do
      assert_difference "Profile.count" do
        User.from_linked_in(@client)
      end
    end
  end
end
