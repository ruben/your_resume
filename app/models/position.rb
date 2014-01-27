class Position < ActiveRecord::Base
  def self.new_from_json(position_data)
    create_params = {
        company: position_data['company']['name'],
        start_date: parse_date(position_data['startDate']),
        end_date: parse_date(position_data['endDate']),
        title: position_data['title'],
        summary: position_data['summary']
    }
    new create_params
  end

  def self.parse_date(date_data)
    Date.new(date_data['year'], date_data['month']) if date_data
  end
end
