module LinkedIn
  class AuthorizationUrl
    def initialize
      @url = "https://www.linkedin.com/uas/oauth2/authorization"
      @params = {
          response_type: "code",
          client_id: "0sskhvc5i3a3",
          state: "5c3dfc38244eeea97e425c8ae79c6a13f08c82182f03d3e29b2b5534ae1c78ad2595e9f253fad9ec4429dda90412d64166fafdef56ac8c8be76e0c0487c94031",
          redirect_uri: REDIRECT_URI,
      }
    end

    def to_s
      [@url, @params.to_query].join("?")
    end
  end
end