module ResumesHelper
  def render_section header, collection
    render partial: 'section', locals: { header: header, collection: collection }
  end
end
