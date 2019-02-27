class Permissao < ApplicationRecord
  # Callbacks
  # Associacoes
  belongs_to :recursos

  belongs_to :perfis

  # Validacoes
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      permissoes.*, 
      recursos. AS recursos_descricao, 
      perfis. AS perfis_descricao
    )).joins(:recursos, :perfis)
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
