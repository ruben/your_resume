module LinkedIn
  class Client
    attr_reader :access_token, :expires_in

    def initialize access_token, expires_in
      @access_token = access_token
      @expires_at = expires_in
    end

    def user_info
      JSON.parse get_user_info @access_token
    end

    def get_user_info access_token
      user_info = RestClient.get user_profile_url,
                                 params:
                                     {oauth2_access_token: access_token,
                                      format: "json"}
      user_info.merge 'access_token' => @access_token, 'expires_at' => @expires_at
    end

    def profile_info
      JSON.parse get_profile_info(@access_token)
    end

    def get_profile_info access_token
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