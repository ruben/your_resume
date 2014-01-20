require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  test "Loads data from LinkedIn client" do
    client = LinkedIn::Client.new "access_info"
    client.stubs(:fetch).returns(LinkedIn::ProfileInfo.new('firstName' => "Rubén", 'summary' => "Rubén has a looooot of experience"))
    @profile = profiles :rubengil_profile
    @profile.load_from(client)
    assert_equal "Rubén", @profile.first_name
    assert_equal "Rubén has a looooot of experience", @profile.summary
  end
end