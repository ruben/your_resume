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

  def profile_info_hash uid, first_name, summary
    '{"id": "' + uid + '", "firstName": "' + first_name + '", "summary": "' + summary + '"}'
  end

  def stub_linked_in_client
    @user = users :rubengil
    linked_in_client = {
        @user.access_token => {
            user_info: [@user.uid, @user.first_name, @user.last_name, @user.email, @user.access_token, @user.expires_at],
            profile_info: [@user.uid, @user.first_name, "Rubén has a loot of experience"]},
        "new_user_access_token" => {
            user_info: ["new_user_uid", "Pepe", "Viyuela", "pepe@gmail.com", "new_user_token", "new_user_expiration"],
            profile_info: ["new_user_uid", "Pepe", "Pepe is very inexperienced"]
        }
    }

    linked_in_client.each do |access_token, stubs|
      stubs.each do |method_name, params|
        LinkedIn::Client.any_instance.stubs("get_#{method_name}".to_sym).with(access_token).returns(send("#{method_name.to_s}_hash", *params))
      end
    end
  end
end

# Fixes error 'NoMethodError: undefined method `env’ for nil:NilClass'.
# Found in http://rubyonrailsthrissur.wordpress.com/2012/01/05/nomethoderror-undefined-method-env-for-nilnilclass/
class ActionController::TestCase
  include Devise::TestHelpers
end
