class Education < ActiveRecord::Base
  belongs_to :profile

  def self.new_from_json(data)
    create_params = {
        school_name: data['schoolName'],
        degree: data['degree'],
        field_of_study: data['fieldOfStudy'],
        start_date: parse_date(data['startDate']),
        end_date: parse_date(data['endDate'])
    }
    new create_params
  end

  def self.parse_date(date_data)
    if date_data
      if date_data['month']
        Date.new(date_data['year'], date_data['month'])
      else
        Date.new(date_data['year'])
      end
    end
  end
end
