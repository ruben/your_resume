class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :trackable

  def self.from_authorization_info authorization_info
    user_info = authorization_info[:user_info]
    unless user = User.where('uid=?', user_info.uid).first
      user = User.create(uid: user_info.uid,
                         email: user_info.email,
                         first_name: user_info.first_name,
                         last_name: user_info.last_name)
    end
    user
  end
end
