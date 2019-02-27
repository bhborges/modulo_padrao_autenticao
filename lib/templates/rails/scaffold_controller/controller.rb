<% namespace_name = controller_class_name.include?('::') ? controller_class_name.split("::").first : false -%>
<% singular_table_name.gsub!("#{namespace_name.downcase}_", '') if namespace_name.present? -%>
<% plural_table_name.gsub!("#{namespace_name.downcase}_", '') if namespace_name.present? -%>
<% route_url_sanitized = namespace_name.present? ? route_url.gsub("#{namespace_name.downcase}/", '') : route_url -%>
<% class_name_sanitized = namespace_name.present? ? class_name.gsub("#{namespace_name}::", '') : class_name -%>
<% index_helper_sanitized = namespace_name.present? ? index_helper.gsub("#{namespace_name.downcase}_", '') : index_helper -%>
<% namespace_name_not_app = namespace_name.present? ? (namespace_name.downcase != 'app' ? "#{namespace_name.downcase}_" : '') : '' -%>
<% have_references = false -%>
<% attributes.each do |attribute| -%>
<% if attribute.reference? -%>
<% have_references = true -%>
<% end -%>
<% end -%>
<% has_account_id = attributes.select{ |attribute| attribute.name == 'account' }.any? -%>
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < <%= "#{namespace_name}::" if namespace_name.present? %>ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
<% if have_references -%>
  before_action :carregar_associacoes, only: [:show, :new, :edit, :create, :update]
<% end -%>
  load_and_authorize_resource only: [:index, :show, :new, :edit, :create, :update, :destroy]

  # GET <%= route_url_sanitized %>
  def index
    @<%= plural_table_name %> = <%= plural_table_name.classify %>.select_lista
                        .pesquisar(params[:s])
                        .paginate(page: params[:page], per_page: params_per_page(params[:per_page]))
  end

  # GET <%= route_url_sanitized %>/:id
  def show
  end

  # GET <%= route_url_sanitized %>/new
  def new
    @<%= singular_table_name %> = <%= orm_class.build(class_name_sanitized) %>
  end

  # GET <%= route_url_sanitized %>/:id/edit
  def edit
  end

  # POST <%= route_url_sanitized %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name_sanitized, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to <%= namespace_name_not_app + index_helper_sanitized %>_path, notice: '<%= singular_table_name.classify %> criado com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT <%= route_url_sanitized %>/:id
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to <%= namespace_name_not_app + index_helper_sanitized %>_path, notice: '<%= singular_table_name.classify %> alterado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE <%= route_url_sanitized %>/:id
  def destroy
    if @<%= orm_instance.destroy %>
      redirect_to <%= namespace_name_not_app + index_helper_sanitized %>_path, notice: '<%= singular_table_name.classify %> excluído com sucesso.'
    else
      redirect_to <%= namespace_name_not_app + index_helper_sanitized %>_path, alert: @<%= singular_table_name %>.errors.full_messages
    end
  end

  private

    # Obter <%= singular_table_name %> por ID
    def set_<%= singular_table_name %>
<% if has_account_id -%>
      @<%= singular_table_name %> = <%= singular_table_name.classify %>.find_by!(id: params[:id] || params[:<%= singular_table_name %>_id], account_id: current_user.account_id)
<% else -%>
      @<%= singular_table_name %> = <%= orm_class.find(class_name_sanitized, "params[:id]") %>
<% end -%>
    end
<% if have_references -%>

    # Carregar registros relacionados
    def carregar_associacoes
<% attributes.each do |attribute| -%>
<% if attribute.reference? -%>
      @<%= attribute.name.pluralize %> = <%= attribute.name.camelize %>.all
<% end -%>
<% end -%>
    end
<% end -%>

    # Permitir parametros utilizaveis
    def <%= "#{singular_table_name}_params" %>
      <%- if attributes_names.empty? -%>
      params[:<%= singular_table_name %>]
      <%- else -%>
      params.require(:<%= singular_table_name %>).permit(
        <%= attributes_names.map { |name| ":#{name}" }.join(",\n        ") %>
      )
      <%- end -%>
    end
end
<% end -%>
