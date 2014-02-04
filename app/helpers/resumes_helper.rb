module ResumesHelper
  def render_section header, collection
    render partial: 'section', locals: { header: header, collection: collection }
  end

  def period(start_date, end_date)
    [start_date, end_date].compact.map {|date| I18n.l date}.join(' - ')
  end
end
