require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Retrieves user if exists" do
    assert_equal users(:rubengil), User.from_authorization_info(authorization_info "ruben-uid", "rubengil22@gmail.com")
  end

  test "Creates user if it doesn't exist" do
    assert_difference "User.count" do
      User.from_authorization_info(authorization_info "newuser-uid", "newuser@gmail.com")
    end
  end
end
