module LinkedIn
  class Client
    def fetch user
      ProfileInfo.new JSON.parse get(user)
    end

    def get user
      RestClient.get self.user_profile_url,
                                 params:
                                     {oauth2_access_token: user.access_token,
                                      format: "json"}
    end

    def user_profile_url
      "https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,summary)"
    end
  end
end