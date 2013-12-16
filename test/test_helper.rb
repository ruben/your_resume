ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "mocha/setup"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def authorization_info uid, email
    {user_info: {uid: uid, email: email},
     access_token: {expires_in: 12345, access_token: "ACCESS_TOKEN"}}
  end

end

# Fixes error 'NoMethodError: undefined method `env’ for nil:NilClass'.
# Found in http://rubyonrailsthrissur.wordpress.com/2012/01/05/nomethoderror-undefined-method-env-for-nilnilclass/
class ActionController::TestCase
  include Devise::TestHelpers
end
