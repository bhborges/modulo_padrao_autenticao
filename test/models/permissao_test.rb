require 'test_helper'

class PermissaoTest < ActiveSupport::TestCase
  context 'validacoes' do
    should belong_to(:recurso)
    should belong_to(:perfil)
  end

  test 'deve salvar permissao' do
    assert @permissao_build.save!
  end
end
