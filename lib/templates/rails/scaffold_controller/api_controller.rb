<% namespace_name = controller_class_name.split("::") -%>
<% namespace_name = namespace_name.size > 1 ? namespace_name[0, namespace_name.size - 1] : [] -%>
<% singular_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% plural_table_name.gsub!("#{namespace_name.join('_').downcase}_", '') if namespace_name.any? -%>
<% route_url_sanitized = namespace_name.any? ? route_url.gsub("#{namespace_name.join('/').downcase}/", '') : route_url -%>
<% class_name_sanitized = namespace_name.any? ? class_name.gsub("#{namespace_name.join('::').downcase}::", '') : class_name -%>
<% index_helper_sanitized = namespace_name.any? ? index_helper.gsub("#{namespace_name.join('_').downcase}_", '') : index_helper -%>
<% namespace_name_not_admin = namespace_name.any? ? (namespace_name.first.downcase != 'admin' ? "#{namespace_name.join('_').downcase}_" : '') : '' -%>
<% attributes_names = plural_table_name.classify.constantize.first.attribute_names - ['created_at', 'updated_at'] rescue [] -%>
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < <%= "#{namespace_name.join('::')}::" %>ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]

  # GET <%= route_url_sanitized %>
  def index
    @<%= plural_table_name %> = <%= plural_table_name.classify %>.paginate(page: api_params[:_page], per_page: params_per_page(api_params[:_limit]))
    json_response(@<%= plural_table_name %>)
  end

  # GET <%= route_url_sanitized %>/1
  def show
    json_response(@<%= singular_table_name %>)
  end

  # POST <%= route_url_sanitized %>
  def create
    @<%= singular_table_name %> = <%= plural_table_name.classify %>.create!(<%= singular_table_name %>_params)
    json_response(@<%= singular_table_name %>, :created)
  end

  # PATCH/PUT <%= route_url_sanitized %>/1
  def update
    @<%= singular_table_name %>.update!(<%= singular_table_name %>_params)
  end

  # DELETE <%= route_url_sanitized %>/1
  def destroy
    @<%= orm_instance.destroy %>!
  end

  private

    # Carregar <%= singular_table_name %> por ID
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= plural_table_name.classify %>.find(params[:id])
    end

    # Somente parametros permitidos
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.permit(
        <%= (attributes_names - %w[id]).map { |name| ":#{name}" }.join(",\n        ") %>
      )
      <%- end -%>
    end
end
<% end -%>
