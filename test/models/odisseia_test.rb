require 'test_helper'

class OdisseiaTest < ActiveSupport::TestCase
  context 'validacoes' do
  end

  test 'deve salvar odisseia' do
    assert @odisseia_build.save!
  end
end
