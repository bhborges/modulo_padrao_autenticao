<% namespace_name = controller_class_name.include?('::') ? controller_class_name.split("::").first : '' -%>
<% class_name_without_namespace = class_name.gsub("#{namespace_name}::", '') -%>
<% singular_table_name_without_namespace = singular_table_name.gsub("#{namespace_name.downcase}_", '') -%>
<% plural_table_name_without_namespace = plural_table_name.gsub("#{namespace_name.downcase}_", '') -%>
<% fixture_name_without_namespace = fixture_name.gsub("#{namespace_name.downcase}_", '') -%>
require_relative 'application_test'

<% module_namespacing do -%>
class <%= controller_class_name %>ControllerTest < Admin::ApplicationTest
  <%- if mountable_engine? -%>
  include Engine.routes.url_helpers

  <%- end -%>
  setup do
    @<%= singular_table_name_without_namespace %> = <%= fixture_name_without_namespace %>(:<%= singular_table_name_without_namespace %>_0)
  end

  test 'deve listar <%= plural_table_name_without_namespace %>' do
    get <%= index_helper %>_url
    assert_response :success
  end

  test 'deve acessar novo <%= singular_table_name_without_namespace %>' do
    get <%= new_helper %>
    assert_response :success
  end

  test 'deve criar <%= singular_table_name_without_namespace %>' do
    assert_difference('<%= class_name_without_namespace %>.count') do
      post <%= index_helper %>_url, params: <%= singular_table_name_without_namespace %>_create_params
    end
    assert_redirected_to <%= index_helper %>_url
  end

  test 'deve mostrar erro ao criar <%= singular_table_name_without_namespace %>' do
    post <%= index_helper %>_url, params: { <%= singular_table_name_without_namespace %>: <%= singular_table_name_without_namespace %>_create_params[:<%= singular_table_name_without_namespace %>].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar <%= singular_table_name_without_namespace %>' do
    get <%= show_helper.gsub("@#{namespace_name.downcase}_", '@') %>
    assert_response :success
  end

  test 'deve editar <%= singular_table_name_without_namespace %>' do
    get <%= edit_helper.gsub("@#{namespace_name.downcase}_", '@') %>
    assert_response :success
  end

  test 'deve atualizar <%= singular_table_name_without_namespace %>' do
    patch <%= show_helper.gsub("@#{namespace_name.downcase}_", '@') %>, params: <%= singular_table_name_without_namespace %>_update_params
    assert_redirected_to <%= index_helper %>_url
  end

  test 'deve mostrar erro ao atualizar <%= singular_table_name_without_namespace %>' do
    patch <%= show_helper.gsub("@#{namespace_name.downcase}_", '@') %>, params: { <%= singular_table_name_without_namespace %>: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar <%= singular_table_name_without_namespace %>' do
    assert_difference('<%= class_name_without_namespace %>.count', -1) do
      delete <%= show_helper.gsub("@#{namespace_name.downcase}_", '@') %>
    end
    assert_redirected_to <%= index_helper %>_url
  end

  private

    def <%= singular_table_name_without_namespace %>_create_params
      {
        <%= singular_table_name_without_namespace %>: {
          <%= attributes_names.map { |name| "#{name}: nil" }.join(",\n          ") %>
        }
      }
    end

    def <%= singular_table_name_without_namespace %>_update_params
      {
        <%= singular_table_name_without_namespace %>: {
        }
      }
    end
end
<% end -%>
