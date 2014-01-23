require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @client = LinkedIn::Client.new("access_token", "expires_in")
    @profile = profiles :rubengil_profile
  end

  test "Loads data from LinkedIn client" do
    LinkedIn::Client.any_instance.stubs(:profile_info).returns(JSON.parse profile_info_hash "ruben_uid", "Rubén","Rubén has a looooot of experience")
    @profile.load_from(@client)
    assert_equal "Rubén", @profile.first_name
    assert_equal "Rubén has a looooot of experience", @profile.summary
  end
end
