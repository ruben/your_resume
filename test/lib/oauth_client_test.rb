require 'test_helper'

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
          return '{"id": "12345", "firstName": "Rubén", "lastName": "Gil", "emailAddress": "rubengil22@gmail.com"}'
        end
      end
      user_info = klass.new.fetch_user_info("access_token")
      assert_equal "12345", user_info.uid
      assert_equal 'Rubén', user_info.first_name
      assert_equal  'Gil', user_info.last_name
      assert_equal  'rubengil22@gmail.com', user_info.email
    end
  end
end