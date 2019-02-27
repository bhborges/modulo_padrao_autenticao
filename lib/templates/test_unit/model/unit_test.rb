require 'test_helper'

<% module_namespacing do -%>
class <%= class_name %>Test < ActiveSupport::TestCase
  context 'validacoes' do
<% attributes.select(&:reference?).each do |attribute| -%>
    should belong_to(:<%= attribute.name %>)
<% end -%>
<% attributes.each do |attribute| -%>
<% if attribute.type == :string -%>
    should validate_length_of(:<%= attribute.name %>).is_at_most(<%= ! attribute.attr_options[:limit].nil? ? attribute.attr_options[:limit] : 255 %>)
<% end -%>
<% end -%>
  end

  test 'deve salvar <%= class_name.downcase %>' do
    assert @<%= class_name.downcase %>_build.save!
  end
end
<% end -%>
