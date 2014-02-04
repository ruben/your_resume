class Profile < ActiveRecord::Base
  include LoadableAssociation

  belongs_to :user
  loads_association :positions
  loads_association :projects
  loads_association :educations

  delegate :email, :first_name, :last_name, to: :user

  def self.create_from client
    profile = new
    profile.load_from client
  end

  def load_from client
    profile_info = client.profile_info
    update first_name: profile_info["firstName"], summary: profile_info["summary"]
    load_children profile_info
    self
  end

  def load_children profile_info
    self.associations.each do |association|
      load_association association, profile_info
    end
  end

  def load_association association, profile_info
    send(association).load_from profile_info[association.to_s]["values"]
  end
end
