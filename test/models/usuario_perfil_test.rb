require 'test_helper'

class UsuarioPerfilTest < ActiveSupport::TestCase
  context 'validacoes' do
    should belong_to(:usuario)
    should belong_to(:perfil)
  end

  test 'deve salvar usuarioperfil' do
    assert @usuarioperfil_build.save!
  end
end
