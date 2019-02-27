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
      recursos. AS recurso_descricao, 
      perfis. AS perfil_descricao
    )).joins(:recurso, :perfil)
  end

  add_scope :pesquisar do |valor|
    where('permissoes.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
