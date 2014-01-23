require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    stub_linked_in_client
    @user = users :rubengil
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

  def stub_linked_in_client
    @user = users :rubengil
    linked_in_client = {
        @user.access_token => {
            user_info: [@user.uid, @user.first_name, @user.last_name, @user.email, @user.access_token, @user.expires_at],
            profile_info: [@user.uid, @user.first_name, "Rubén has a loot of experience"]},
        "new_user_access_token" => {
            user_info: ["new_user_uid", "Pepe", "Viyuela", "pepe@gmail.com", "new_user_token", "new_user_expiration"],
            profile_info: ["new_user_uid", "Pepe", "Pepe is very inexperienced"]
        }
    }

    linked_in_client.each do |access_token, stubs|
      stubs.each do |method_name, params|
        LinkedIn::Client.any_instance.stubs("get_#{method_name}".to_sym).with(access_token).returns(send("#{method_name.to_s}_hash", *params))
      end
    end
  end
end
