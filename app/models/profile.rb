class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :positions

  def load_from client
    profile_info = client.profile_info
    update first_name: profile_info["firstName"], summary: profile_info["summary"]
    positions_data = profile_info["positions"]["values"]
    positions_data.each do |position_data|
       positions << Position.new_from_json(position_data)
    end
  end
end
