require 'test_helper'

class RecursoTest < ActiveSupport::TestCase
  context 'validacoes' do
    should validate_length_of(:nome).is_at_most(255)
    should validate_length_of(:descricao).is_at_most(255)
    should validate_length_of(:tipo).is_at_most(255)
  end

  test 'deve salvar recurso' do
    assert @recurso_build.save!
  end
end
