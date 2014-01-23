require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @user = users :rubengil
    @profile = @user.profile
    stub_linked_in_client
  end

  test "Loads data from LinkedIn client" do
    @client = LinkedIn::Client.new(@user.access_token, "expires_in")
    @profile.load_from(@client)
    assert_equal "Rubén has a loot of experience", @profile.summary
  end
end
