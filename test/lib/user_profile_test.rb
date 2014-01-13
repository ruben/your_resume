require 'test_helper'

module LinkedIn
  class UserProfileTest < ActiveSupport::TestCase
     test "fetches user profile" do
       user = users :rubengil
       Client.stubs(:get).with(user).returns('{"id": "12345", "firstName": "Rubén", "summary": "Rubén Summary"}')
       @user_profile = Client.fetch(user)
       assert_equal "Rubén", @user_profile.first_name
       assert_equal "Rubén Summary", @user_profile.summary
     end
  end
end