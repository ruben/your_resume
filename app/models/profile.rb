module LoadDataExtension
  def load_data data
    self.transaction do
      association.destroy_all
      data.each do |data|
        association.concat class_constant.new_from_json(data)
      end
    end
  end

  def association
    proxy_association
  end

  def association_name
    association.reflection.name
  end

  def class_constant
    Object.const_get(association_name.to_s.singularize.classify)
  end
end

class Profile < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :positions, -> { extending LoadDataExtension }
  has_many :projects, -> { extending LoadDataExtension }
  has_many :educations, -> { extending LoadDataExtension }

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
    associations.each do |association|
      load_association association, profile_info
    end
  end

  def load_association association, profile_info
    send(association).load_data profile_info[association.to_s]["values"]
  end

  def associations
    [:positions, :projects, :educations]
  end
end
