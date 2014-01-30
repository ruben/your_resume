class Project < ActiveRecord::Base
  def self.new_from_json(project_data)
    create_params = {
        description: project_data['description'],
        name: project_data['name'],
        url: project_data['url']
    }
    new create_params
  end
end
