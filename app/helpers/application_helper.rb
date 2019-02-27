module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def check_box_tag(name, value = '1', checked = false, options = {})
    html_options = { type: 'checkbox', name: name, id: sanitize_to_id(name), value: value }
    html_options[:checked] = 'checked' if checked
    content_html = tag :input, html_options.merge(options).stringify_keys
    content_html << tag(:label, class: 'el-checkbox-style', for: html_options[:id])

    html_class = 'el-checkbox'
    html_class << " #{html_options[:class]}" if html_options[:class].present?
    %(<div class="#{html_class}">#{content_html}</div>).html_safe
  end

  def current_path?(test_path)
    controller.request.path == test_path
  end
end
