require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    @profile = @user.profile
    stub_get_profile_info
    @client = LinkedIn::Client.new(@user.access_token, "expires_in")
  end

  test "Loads summary" do
    @profile.load_from(@client)
    assert_not_nil @profile.summary
  end

  test "Loads positions" do
    assert_difference "@profile.positions.count", @client.profile_info['positions']['_total'] do
      @profile.load_from(@client)
      p @profile.positions
    end
  end
end
