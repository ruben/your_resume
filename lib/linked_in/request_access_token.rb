require 'rest_client'

module LinkedIn
  class RequestAccessToken
    def self.fetch authorization_code
      new.fetch authorization_code
    end

    def fetch authorization_code
      JSON.parse get authorization_code
    end

    ## Gets authorization response as json
    def get authorization_code
      response = RestClient.post ACCESS_TOKEN_URL,
                      grant_type: "authorization_code",
                      code: authorization_code,
                      redirect_uri: REDIRECT_URI,
                      client_id: API_KEY,
                      client_secret: SECRET_KEY
      p response
      response
    end
  end
end