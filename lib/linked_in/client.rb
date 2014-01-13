module LinkedIn
  class Client
    attr_reader :first_name, :summary

    def self.fetch user
      Client.new JSON.parse get(user)
    end

    def self.get user
      get_user_info user.access_token
    end

    def self.get_user_info access_token
      user_info = RestClient.get self.user_profile_url,
                                 params:
                                     {oauth2_access_token: access_token,
                                      format: "json"}
      user_info
    end

    def initialize user_info
      @first_name = user_info['firstName']
      @summary = user_info['summary']
    end

    def self.user_profile_url
      "https://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,summary)"
    end
  end
end