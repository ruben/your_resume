class Project < ActiveRecord::Base
  extend CreatableFromJson

  def self.create_params data
    {
        description: data['description'],
        name: data['name'],
        url: data['url']
    }
  end
end
