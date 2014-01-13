require 'test_helper'

class ProfileTest < ActiveSupport::TestCase

  test "Loads data from LinkedIn client" do
    client = LinkedIn::Client.new
    client.stubs(:fetch).returns(LinkedIn::ProfileInfo.new('firstName' => "Rubén", 'summary' => "Rubén has a lot of experience"))
    assert_difference "Profile.count" do
      @profile = Profile.load_from(client)
    end
    assert_equal "Rubén", @profile.first_name
    assert_equal "Rubén has a lot of experience", @profile.summary
  end
end
