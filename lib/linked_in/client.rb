module LinkedIn
  class Client
    attr_reader :access_token, :expires_in

    def initialize access_token, expires_in
      @access_token = access_token
      @expires_at = expires_in
    end

    def user_info
      OauthUserInfo.new(JSON.parse get_user_info @access_token)
    end

    def get_user_info access_token
      user_info = RestClient.get user_profile_url,
                                 params:
                                     {oauth2_access_token: access_token,
                                      format: "json"}
      user_info
    end

    def profile_info
      ProfileInfo.new JSON.parse get(@access_token)
    end

    def get access_token
      RestClient.get self.user_profile_url,
                     params:
                         {oauth2_access_token: access_token,
                          format: "json"}
    end

    def user_profile_url
      "https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,summary)"
    end
  end
end