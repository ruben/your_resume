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

  def access_token_hash access_token
    '{"expires_in":5184000, "access_token": "' + access_token + '"}'
  end

  def user_info_hash uid, first_name, last_name, email_address, access_token, expires_at
    '{"id": "' + uid + '", "firstName": "' + first_name + '", "lastName": "' + last_name + '", "emailAddress": "' + email_address + '", "access_token": "' + access_token + '", "expires_at": "' + expires_at.to_s + '"}'
  end

  def profile_info_hash first_name, summary
    '{"firstName": "' + first_name + '", "summary": "' + summary + '"}'
  end

  def stub_get_user_info access_token, user
    LinkedIn::Client.any_instance.stubs(:get_user_info).with(access_token).returns(user_info_hash user.uid, user.first_name, user.last_name, user.email, user.access_token, user.expires_at)
  end

  def stub_get_profile_info access_token, profile
    LinkedIn::Client.any_instance.stubs(:get_profile_info).with(access_token).returns(profile_info_hash profile.first_name, profile.summary)
  end
end

# Fixes error 'NoMethodError: undefined method `env’ for nil:NilClass'.
# Found in http://rubyonrailsthrissur.wordpress.com/2012/01/05/nomethoderror-undefined-method-env-for-nilnilclass/
class ActionController::TestCase
  include Devise::TestHelpers
end
