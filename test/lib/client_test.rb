require 'test_helper'
require 'linked_in'

module LinkedIn
  class ClientTest < ActiveSupport::TestCase
    setup do
      @linked_in_client = Client.new("access_token", "expires_in")
    end

    test "fetches user info" do
      @linked_in_client.expects(:get_user_info).returns('{"id": "12345", "firstName": "Rubén", "lastName": "Gil", "emailAddress": "rubengil22@gmail.com"}')
      user_info = @linked_in_client.user_info
      assert_not_nil user_info
    end

    test "fetches profile info" do
      @linked_in_client.expects(:get_profile_info).returns('{"firstName": "Rubén", "summary": "Rubén has a lot of experience"}')
      profile_info = @linked_in_client.profile_info
      assert_not_nil profile_info
    end
  end
end