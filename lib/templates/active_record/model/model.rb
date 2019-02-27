<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # Callbacks
  # Associacoes
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>

<% end -%>
<% attributes.select(&:token?).each do |attribute| -%>
  has_secure_token<% if attribute.name != "token" %> :<%= attribute.name %><% end %>

<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password

<% end -%>
  # Validacoes
<% attributes.each do |attribute| -%>
<% if attribute.type == :string -%>
  validates :<%= attribute.name %>, length: { maximum: <%= ! attribute.attr_options[:limit].nil? ? attribute.attr_options[:limit] : 255 %> }
<% end -%>
<% end -%>
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      <%= plural_table_name %>.*<%= ', ' if attributes.select(&:reference?).any? %>
<% attributes.select(&:reference?).each do |attribute| -%>
      <%= "#{attribute.name.pluralize}.#{attribute.name.classify.constantize.column_names.include?('name') ? 'name' : attribute.name.classify.constantize.column_names.include?('description') ? 'description' : '' }" %> AS <%= attribute.name %>_descricao<%= ', ' if attribute.name != attributes.select(&:reference?).last.name %>
<% end -%>
    ))<% if attributes.select(&:reference?).any? %>.joins(<% attributes.select(&:reference?).each do |attribute| -%>:<%= attribute.name %><% if attribute.name != attributes.select(&:reference?).last.name %>, <% end %><% end -%>)<% end %>
  end

  add_scope :pesquisar do |valor|
    where('<%= plural_table_name %>.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
<% end -%>
