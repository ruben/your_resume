class Project < ActiveRecord::Base
  extend CreateFromData

  def self.create_params data
    {
        description: data['description'],
        name: data['name'],
        url: data['url']
    }
  end
end
