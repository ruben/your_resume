class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.from_authorization_info authorization_info
    unless user = User.where('uid=?', authorization_info[:user_info][:uid]).first
      user = User.create(uid: authorization_info[:user_info][:uid], email: authorization_info[:user_info][:email])
    end
    user
  end
end
