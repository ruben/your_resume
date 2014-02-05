class Language < ActiveRecord::Base
  extend CreatableFromJson

  def self.create_params data
    {
        name: data['language']['name']
    }
  end
end
