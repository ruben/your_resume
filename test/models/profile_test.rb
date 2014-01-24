require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    @profile = @user.profile
  end

  test "Loads data from LinkedIn client" do
    stub_get_profile_info @user.access_token, Profile.new(first_name: "Rubén", summary: "Rubén has a loot of experience")
    @client = LinkedIn::Client.new(@user.access_token, "expires_in")
    @profile.load_from(@client)
    assert_equal "Rubén has a loot of experience", @profile.summary
  end
end
