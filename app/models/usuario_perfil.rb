class UsuarioPerfil < ApplicationRecord
  # Callbacks
  # Associacoes
  belongs_to :usuario

  belongs_to :perfil

  # Validacoes
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      usuarios_perfis.*, 
      usuarios. AS usuario_descricao, 
      perfis. AS perfil_descricao
    )).joins(:usuario, :perfil)
  end

  add_scope :pesquisar do |valor|
    where('usuarios_perfis.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
