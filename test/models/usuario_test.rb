require 'test_helper'

class UsuarioTest < ActiveSupport::TestCase
  context 'validacoes' do
    should validate_length_of(:nome).is_at_most(255)
    should validate_length_of(:login).is_at_most(255)
  end

  test 'deve salvar usuario' do
    assert @usuario_build.save!
  end
end
