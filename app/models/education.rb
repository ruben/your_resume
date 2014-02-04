class Education < ActiveRecord::Base
  extend CreatableFromJson
  belongs_to :profile

  def self.create_params data
    {
        school_name: data['schoolName'],
        degree: data['degree'],
        field_of_study: data['fieldOfStudy'],
        start_date: parse_date(data['startDate']),
        end_date: parse_date(data['endDate'])
    }
  end
end
