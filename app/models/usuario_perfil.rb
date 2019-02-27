class UsuarioPerfil < ApplicationRecord
  # Callbacks
  # Associacoes
  belongs_to :usuarios

  belongs_to :perfis

  # Validacoes
  # validates :descricao, presence: true, uniqueness: true, length: { maximum: 255 }

  # Escopos

  add_scope :select_lista do
    select(%(
      usuario_perfis.*, 
      usuarios. AS usuarios_descricao, 
      perfis. AS perfis_descricao
    )).joins(:usuarios, :perfis)
  end

  add_scope :pesquisar do |valor|
    where('usuario_perfis.id = :id OR 1 LIKE :valor', id: valor, valor: "#{valor}%")
  end

  # Metodos estaticos
  # Metodos publicos
  # Metodos GET
  # Metodos SET

  # Nota: os metodos somente utilizados em callbacks ou utilizados somente por essa
  #       propria classe deverao ser privados (remover essa anotacao)
end
