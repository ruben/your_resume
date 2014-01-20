class User < ActiveRecord::Base
  has_one :profile
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  def self.from_authorization_info linked_in_client
    authorization_info = linked_in_client.authorization_info
    user_info = authorization_info[:user_info]
    access_info = authorization_info[:access_info]
    unless user = User.where('uid=?', user_info.uid).first
      user = User.create(uid: user_info.uid,
                         email: user_info.email,
                         first_name: user_info.first_name,
                         last_name: user_info.last_name,
                         access_token: access_info['access_token'],
                         expires_at: access_info['expires_in'])
      profile_info = linked_in_client.profile_info
      user.create_profile(first_name: profile_info.first_name,
                          summary: profile_info.summary)

    else
      user.update(access_token: access_info['access_token'],
                  expires_at: access_info['expires_in'])
    end
    user
  end
end
