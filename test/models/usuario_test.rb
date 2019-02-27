require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  context 'validacoes' do
  end

  test 'deve salvar usuario' do
    assert @usuario_build.save!
  end
end
