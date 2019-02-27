class Perfil < ApplicationRecord
  # Callbacks
  # Associacoes
  # Validacoes
  validates :descricao, length: { maximum: 255 }
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      perfis.*
    ))
  end

  add_scope :pesquisar do |valor|
    where('perfis.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
