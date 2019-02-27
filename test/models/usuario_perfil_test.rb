require 'test_helper'

class UsuarioPerfilTest < ActiveSupport::TestCase
  context 'validacoes' do
    should belong_to(:usuarios)
    should belong_to(:perfis)
  end

  test 'deve salvar usuarioperfil' do
    assert @usuarioperfil_build.save!
  end
end
