require 'test_helper'
require 'linked_in'

module LinkedIn
  class ClientTest < ActiveSupport::TestCase
    setup do
      @client = Client.new("access_token", "expires_in")
    end

    test "fetches user info" do
      @client.expects(:get_user_info).returns(user_info_hash 'ruben-uid', 'Rubén', 'Gil', 'rubengil22@gmail.com', "access_token", "expires_in")
      user_info = @client.user_info
      assert_not_nil user_info
    end

    test "fetches profile info" do
      @client.expects(:get_profile_info).returns(profile_info_hash "Rubén", "Rubén has a lot of experience")
      profile_info = @client.profile_info
      assert_not_nil profile_info
    end
  end
end