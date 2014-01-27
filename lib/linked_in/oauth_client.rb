require 'rest_client'

# TODO Refactor
module LinkedIn
  class OauthClient
    def self.authorize authorization_code
      oauth_client = new
      oauth_client.access_token authorization_code
    end

    def self.authorize_url
      new.authorize_url
    end

    def access_token authorization_code
      JSON.parse get_access_token authorization_code
    end

    def get_access_token authorization_code
      RestClient.post access_token_url,
                      grant_type: "authorization_code",
                      code: authorization_code,
                      redirect_uri: redirect_uri,
                      client_id: API_KEY,
                      client_secret: SECRET_KEY
    end

    def authorize_url
      ["https://www.linkedin.com/uas/oauth2/authorization", authorize_params.to_query].join("?")
    end

    private
    def access_token_url
      'https://www.linkedin.com/uas/oauth2/accessToken'
    end

    def authorize_params
      {response_type: response_type,
       client_id: "0sskhvc5i3a3",
       scope: scope,
       state: "5c3dfc38244eeea97e425c8ae79c6a13f08c82182f03d3e29b2b5534ae1c78ad2595e9f253fad9ec4429dda90412d64166fafdef56ac8c8be76e0c0487c94031",
       redirect_uri: redirect_uri,
      }
    end

    def response_type
      "code"
    end

    def scope
      "r_fullprofile r_emailaddress"
    end

    def redirect_uri
      'http://localhost:3000/linkedin_authorization/callback'
    end
  end
end