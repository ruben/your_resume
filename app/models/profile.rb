class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  end

  def load_from client
    profile_info = client.fetch user
    update(first_name: profile_info.first_name, summary: profile_info.summary)
  end
end
