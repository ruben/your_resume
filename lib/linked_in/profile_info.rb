module LinkedIn
  class ProfileInfo
    attr_reader :first_name, :summary

    def initialize profile_info
      @first_name = profile_info['firstName']
      @summary = profile_info['summary']
    end
  end
end