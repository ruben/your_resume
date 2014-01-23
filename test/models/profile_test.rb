require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @client = mock('client')
    @profile = profiles :rubengil_profile
  end

  test "Loads data from LinkedIn client" do
    @client.stubs(:profile_info).returns(JSON.parse '{"firstName": "Rubén", "summary": "Rubén has a looooot of experience"}')
    @profile.load_from(@client)
    assert_equal "Rubén", @profile.first_name
    assert_equal "Rubén has a looooot of experience", @profile.summary
  end
end
