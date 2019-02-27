<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% class_name_without_namespace = class_name.gsub("#{namespace_name.join('::')}::", '') -%>
<% singular_table_name_without_namespace = singular_table_name.gsub("#{namespace_name.join('_').downcase}_", '') -%>
<% plural_table_name_without_namespace = plural_table_name.gsub("#{namespace_name.join('_').downcase}_", '') -%>
<% fixture_name_without_namespace = fixture_name.gsub("#{namespace_name.join('_').downcase}_", '') -%>
require_relative 'application_test'

<% module_namespacing do -%>
class <%= controller_class_name %>ControllerTest < <%= "#{namespace_name.join('::')}::" %>ApplicationTest
  <%- if mountable_engine? -%>
  include Engine.routes.url_helpers

  <%- end -%>
  setup do
    @<%= singular_table_name_without_namespace %> = <%= fixture_name_without_namespace %>(:<%= singular_table_name_without_namespace %>_0)
  end

  test 'deve listar <%= plural_table_name_without_namespace %>' do
    get <%= index_helper %>_url, auth_params
    assert_response :success
  end

  test 'deve visualizar <%= singular_table_name_without_namespace %>' do
    get <%= show_helper.gsub("@#{namespace_name.join('_').downcase}_", '@') %>, auth_params
    assert_response :success
  end

  test 'deve criar <%= singular_table_name_without_namespace %>' do
    assert_difference('<%= class_name_without_namespace %>.count') do
      post <%= index_helper %>_url, auth_params.merge(params: <%= singular_table_name_without_namespace %>_create_params)
    end
    assert_response :created
  end

  test 'deve atualizar <%= singular_table_name_without_namespace %>' do
    patch <%= show_helper.gsub("@#{namespace_name.join('_').downcase}_", '@') %>, auth_params.merge(params: <%= singular_table_name_without_namespace %>_update_params)
    assert_response :success
  end

  test 'deve deletar <%= singular_table_name_without_namespace %>' do
    assert_difference('<%= class_name_without_namespace %>.count', -1) do
      delete <%= show_helper.gsub("@#{namespace_name.join('_').downcase}_", '@') %>, auth_params
    end
    assert_response :success
  end

  private

    def <%= singular_table_name_without_namespace %>_create_params
      {
        <%= attributes_names.map { |name| "#{name}: nil" }.join(",\n        ") %>
      }
    end

    def <%= singular_table_name_without_namespace %>_update_params
      {
      }
    end
end
<% end -%>
