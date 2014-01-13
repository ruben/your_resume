class Profile < ActiveRecord::Base
  belongs_to :user

  def self.load_from client
    profile_info = client.fetch
    create(first_name: profile_info.first_name, summary: profile_info.summary)
  end
end
