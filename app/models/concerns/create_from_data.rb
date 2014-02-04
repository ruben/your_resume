module CreateFromData
  def new_from_json data
    new create_params data
  end

  protected
  def create_params data
    raise "Must override create_data function."
  end

  def parse_date data
    if data
      if data['month']
        Date.new(data['year'], data['month'])
      else
        Date.new(data['year'])
      end
    end
  end
end