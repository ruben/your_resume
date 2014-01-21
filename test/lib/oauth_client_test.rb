require 'test_helper'
require 'linked_in'

module LinkedIn
  class OauthClientTest < ActiveSupport::TestCase
    test "fetches access token" do
      klass = Class.new(OauthClient) do
        define_method(:get_access_token) do |authorization_code|
          return '{"expires_in":5184000, "access_token":"AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR"}'
        end
      end
      request_access_token = klass.new.access_token('authorization_code')
      assert_equal "AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR", request_access_token['access_token']
    end
  end
end