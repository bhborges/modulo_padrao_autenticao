class ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper

  def check_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    html_options = { type: 'checkbox' }
    content_html = @template.check_box(@object_name, method, objectify_options(options.except(:class, 'class')), checked_value, unchecked_value)
    content_html << tag(:label, class: 'el-checkbox-style', for: sanitize_to_id("#{@object_name}_#{method}"))
    @template.content_tag :div, class: "el-checkbox #{options[:class].to_s}" do
      content_html
    end
  end

  def switch_box(method, options = {}, checked_value = '1', unchecked_value = '0')
    content_html = @template.check_box(@object_name, method, objectify_options(options.except(:class, 'class')), checked_value, unchecked_value)
    content_html << tag(:label, class: 'el-switch-style', for: sanitize_to_id("#{@object_name}_#{method}"))
    @template.content_tag :div, class: "el-switch #{options[:class].to_s}" do
      content_html
    end
  end
end
