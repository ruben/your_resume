class Certification < ActiveRecord::Base
  extend CreatableFromJson

  def self.create_params data
    {
        name: data['name']
    }
  end
end
