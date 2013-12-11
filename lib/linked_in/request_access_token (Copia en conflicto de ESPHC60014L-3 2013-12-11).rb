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
      RestClient.post "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code" \
                                           "&code=AUTHORIZATION_CODE" \
                                           "&redirect_uri=YOUR_REDIRECT_URI" \
                                           "&client_id=YOUR_API_KEY" \
                                           "&client_secret=YOUR_SECRET_KEY"
    end
  end
end