class User < ActiveRecord::Base
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable
  def self.from_linked_in linked_in_client
    user_info = linked_in_client.user_info
    unless user = User.where('uid=?', user_info["id"]).first
      user = User.create(uid: user_info["id"],
                         email: user_info["emailAddress"],
                         first_name: user_info["firstName"],
                         last_name: user_info["lastName"],
                         access_token: user_info["access_token"],
                         expires_at: user_info["expires_in"])
      profile_info = linked_in_client.profile_info
      user.create_profile(first_name: profile_info["firstName"], summary: profile_info["summary"])
    else
      user.update(access_token: user_info["access_token"],
                  expires_at: user_info["expires_in"])
    end
    user
  end
end
