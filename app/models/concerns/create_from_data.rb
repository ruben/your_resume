module CreateFromData
  def new_from_json data
    new create_params data
  end

  protected
  def create_params data
    raise "Must override create_data function."
  end

  def parse_date data
    return data unless data
    not_nil_parameters = [data['year'], data['month']].compact
    Date.new(*not_nil_parameters)
  end
end