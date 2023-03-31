module ApplicationHelper
  def render_svg(field, opts = {})
    svg_tag(field.value.download, opts)
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
end
