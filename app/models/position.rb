class Position < ActiveRecord::Base
  extend CreateFromData

  protected
  def self.create_params data
    {
        company: data['company']['name'],
        start_date: parse_date(data['startDate']),
        end_date: parse_date(data['endDate']),
        title: data['title'],
        summary: data['summary']
    }
  end
end
