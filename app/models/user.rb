class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  def self.from_linked_in client
    user_info = client.user_info
    unless user = User.where('uid=?', user_info["id"]).first
      create_params = {
          uid:           user_info["id"],
          email:         user_info["emailAddress"],
          first_name:    user_info["firstName"],
          last_name:     user_info["lastName"],
          access_token:  user_info["access_token"],
          expires_at:    user_info["expires_in"]
      }
      user = User.create(create_params)
      user.profile = Profile.create_from client
    else
      user.update(access_token: user_info["access_token"],
                  expires_at:   user_info["expires_in"])
    end
    user
  end
end
