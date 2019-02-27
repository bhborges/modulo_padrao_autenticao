require 'test_helper'

class PerfilTest < ActiveSupport::TestCase
  context 'validacoes' do
    should validate_length_of(:descricao).is_at_most(255)
  end

  test 'deve salvar perfil' do
    assert @perfil_build.save!
  end
end
