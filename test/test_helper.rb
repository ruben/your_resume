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
    access_token_json = <<-JSON
    {
      "expires_in": 5184000,
      "access_token": "#{access_token}"
    }
    JSON
    access_token_json
  end

  def stub_get_user_info user
    user_info = File.read "test/fixtures/users/#{user}.json"
    LinkedIn::Client.any_instance.stubs(:get_user_info).returns(user_info)
  end

  def stub_get_profile_info user
    profile_info = File.read "test/fixtures/profiles/#{user}.json"
    LinkedIn::Client.any_instance.stubs(:get_profile_info).returns(profile_info)
  end

  def stub_linked_in_client user, access_token
    stub_get_user_info user
    stub_get_profile_info user
    @client = LinkedIn::Client.new(access_token, "expires_in")
  end
end

# Fixes error 'NoMethodError: undefined method `env’ for nil:NilClass'.
# Found in http://rubyonrailsthrissur.wordpress.com/2012/01/05/nomethoderror-undefined-method-env-for-nilnilclass/
class ActionController::TestCase
  include Devise::TestHelpers
end
