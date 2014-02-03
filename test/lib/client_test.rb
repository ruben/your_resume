require 'test_helper'
require 'linked_in'

module LinkedIn
  class ClientTest < ActiveSupport::TestCase
    setup do
      @client = Client.new("access_token", "expires_in")
    end

    test "fetches user info" do
      @client.expects(:get_people).with('id,first-name,last-name,email-address').returns(File.read 'test/fixtures/users/ruben.json')
      user_info = @client.user_info
      assert_not_nil user_info
    end

    test "fetches profile info" do
      @client.expects(:get_people).with('summary,positions,projects,educations').returns(File.read 'test/fixtures/profiles/ruben.json')
      profile_info = @client.profile_info
      assert_not_nil profile_info
    end
  end
end