module LinkedIn
  class OauthUserInfo
    attr_reader :uid, :first_name, :last_name, :email

    def initialize user_info_hash
      @uid = user_info_hash["id"]
      @first_name = user_info_hash["firstName"]
      @last_name = user_info_hash["lastName"]
      @email = user_info_hash["emailAddress"]
    end
  end
end