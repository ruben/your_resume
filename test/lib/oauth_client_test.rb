require 'test_helper'
require 'linked_in/oauth_client'

module LinkedIn
  class OauthClientTest < ActiveSupport::TestCase
    test "fetches access token" do
      klass = Class.new(OauthClient) do
        define_method(:get_access_token) do |authorization_code|
          return '{"expires_in":5184000, "access_token":"AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR"}'
        end
      end
      request_access_token = klass.new.fetch_access_token('authorization_code')
      assert_equal "AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR", request_access_token['access_token']
    end

    test "fetches user info" do
      klass = Class.new(OauthClient) do
        define_method(:get_user_info) do |access_token|
          return '{"uid": "12345", "first-name": "Rubén", "last-name": "Gil", "e-mail-address": "rubengil22@gmail.com"}'
        end
      end
      assert_equal({"uid" => "12345", "first-name" => 'Rubén', "last-name" => 'Gil', "e-mail-address" => 'rubengil22@gmail.com'}, klass.new.fetch_user_info("access_token"))
    end
  end
end