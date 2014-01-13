module LinkedIn
  class Client
    def fetch user
      Client.new JSON.parse get(user)
    end

    def get user
      get_user_info user.access_token
    end

    def get_user_info access_token
      user_info = RestClient.get self.user_profile_url,
                                 params:
                                     {oauth2_access_token: access_token,
                                      format: "json"}
      new ProfileInfo(user_info)
    end

    def user_profile_url
      "https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,summary)"
    end
  end
end