class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :positions
  has_many :projects

  def self.create_from client
    profile = new
    profile.load_from client
  end

  def load_from client
    profile_info = client.profile_info
    update first_name: profile_info["firstName"], summary: profile_info["summary"]
    load_positions(profile_info["positions"]["values"])
    self
  end

  private
  def load_positions(positions_data)
    self.transaction do
      positions.destroy_all
      positions_data.each do |position_data|
        positions << Position.new_from_json(position_data)
      end
    end
  end
end
