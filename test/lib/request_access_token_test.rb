require 'test_helper'
require 'linked_in/request_access_token'

module LinkedIn
  class RequestAccessTokenTest < ActiveSupport::TestCase

    test "gets access token" do

      klass = Class.new(RequestAccessToken) do
        define_method(:get) do |authorization_code|
          return '{"expires_in":5184000, "access_token":"AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR"}'
        end
      end

      request_access_token = klass.fetch('authorization_code')
      assert_equal "AQXdSP_W41_UPs5ioT_t8HESyODB4FqbkJ8LrV_5mff4gPODzOYR", request_access_token['access_token']
    end
  end
end