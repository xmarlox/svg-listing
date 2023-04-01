module ApplicationHelper
  def render_svg(field, opts = {})
    svg = field.try(:value) || field
    Rails.cache.fetch ["svg", "file", svg.attachment.filename, svg.record.updated_at.to_i, opts.to_s] do
      svg_tag(svg.download, opts)
    end
  end

  def svg_tag(file, opts = {})
    content =
      if file.is_a?(Tempfile)
        file.read
      elsif file.is_a?(String) && file.end_with?(".svg")
        file = Rails.root.join("app", "assets", "images", file).to_s
        File.read(file) if File.exist?(file)
      else
        file
      end
    svg = Nokogiri::HTML::DocumentFragment.parse(content).at_css('svg')
    opts.each { |attr, value| svg[attr.to_s] = value }

    svg.to_html.html_safe
  end

  def cache_key(purpose, illustration)
    [
      purpose,
      illustration.slug,
      illustration.id,
      illustration.svg.attachment.filename,
      illustration.updated_at.to_i,
    ]
  end

  def display_name(illustration)
    Rails.cache.fetch cache_key(:name, illustration) do
      illustration.name.titleize
    end
  end

  def display_tags(illustration)
    Rails.cache.fetch cache_key(:tags, illustration) do
      illustration.tag_list.join(", ")
    end
  end
end
