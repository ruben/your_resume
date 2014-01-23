class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  def load_from client
    profile_info = client.profile_info
    update first_name: profile_info["firstName"], summary: profile_info["summary"]
  end
end
