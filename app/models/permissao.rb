class Permissao < ApplicationRecord
  # Callbacks
  # Associacoes
  belongs_to :recurso

  belongs_to :perfil

  # Validacoes
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      permissoes.*,
      recursos.descricao AS recurso_descricao,
      perfis.descricao AS perfil_descricao
    )).joins(:recurso, :perfil)
  end

  add_scope :pesquisar do |valor|
    where('permissoes.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  scope :por_usuario, ->(usuario_id){
    select('recursos.nome AS recurso_nome, recursos.tipo as recurso_tipo, permissoes.*').
    joins('JOIN recursos ON recursos.id = permissoes.recurso_id
           JOIN usuarios_perfis ON usuarios_perfis.perfil_id = permissoes.perfil_id').
    where('usuarios_perfis.usuario_id = ?', usuario_id)
  }

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
