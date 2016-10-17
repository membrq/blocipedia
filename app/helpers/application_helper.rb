module ApplicationHelper

  def markdown_to_html(text)
    converter = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    converter.render(text).html_safe
  end
end
