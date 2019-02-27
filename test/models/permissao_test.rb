require 'test_helper'

class PermissaoTest < ActiveSupport::TestCase
  context 'validacoes' do
    should belong_to(:recursos)
    should belong_to(:perfis)
  end

  test 'deve salvar permissao' do
    assert @permissao_build.save!
  end
end
