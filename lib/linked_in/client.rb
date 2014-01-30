module LinkedIn
  class Client
    attr_reader :access_token, :expires_in

    def initialize access_token, expires_in
      @access_token = access_token
      @expires_at = expires_in
    end

    def user_info
      user_info = parse get_user_info
      user_info = user_info.merge 'access_token' => @access_token, 'expires_at' => @expires_at
      user_info
    end

    def profile_info
      parse get_profile_info
    end

    private
    def parse json
      JSON.parse json
    end

    def get_user_info
      get_people "id,first-name,last-name,email-address"
    end

    def get_profile_info
      get_people "summary,positions,projects"
    end

    def get_people attrs
      RestClient.get "#{user_profile_url}:(#{attrs})",
                     params:
                         {oauth2_access_token: @access_token,
                          format: "json"}
    end

    def user_profile_url
      "https://api.linkedin.com/v1/people/~"
    end
  end
end