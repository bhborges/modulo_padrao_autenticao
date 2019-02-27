class Odisseia < ApplicationRecord
  # Callbacks
  # Associacoes
  # Validacoes
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      odisseias.*
    ))
  end

  add_scope :pesquisar do |valor|
    where('odisseias.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
