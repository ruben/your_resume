require 'rest_client'

module LinkedIn
  class OauthClient

    def self.authorize authorization_code
      oauth_client = new
      access_token = oauth_client.fetch_access_token  authorization_code
      oauth_client.fetch_user_info access_token
    end

    def fetch_user_info access_token
      JSON.parse get_user_info access_token
    end

    def get_user_info access_token
      RestClient.get "https://api.linkedin.com/v1/people/~?format=json"
    end

    def fetch_access_token authorization_code
      JSON.parse get_access_token authorization_code
    end

    ## Gets authorization response as json
    def get_access_token authorization_code
      RestClient.post ACCESS_TOKEN_URL,
                      grant_type: "authorization_code",
                      code: authorization_code,
                      redirect_uri: REDIRECT_URI,
                      client_id: API_KEY,
                      client_secret: SECRET_KEY
    end
  end
end