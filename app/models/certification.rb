class Certification < ActiveRecord::Base
  extend CreatableFromJson

  def self.create_params data
    {
        name: data['name'],
        authority: data['authority']['name']
    }
  end
end
