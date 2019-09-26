require_relative 'application_test'

class RecursosControllerTest < ApplicationTest
  setup do
    @recurso = recursos(:recurso_0)
  end

  test 'deve listar recursos' do
    get recursos_url
    assert_response :success
  end

  test 'deve acessar novo recurso' do
    get new_recurso_url
    assert_response :success
  end

  test 'deve criar recurso' do
    assert_difference('Recurso.count') do
      post recursos_url, params: recurso_create_params
    end
    assert_redirected_to recursos_url
  end

  test 'deve mostrar erro ao criar recurso' do
    post recursos_url, params: { recurso: recurso_create_params[:recurso].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar recurso' do
    get recurso_url(@recurso)
    assert_response :success
  end

  test 'deve editar recurso' do
    get edit_recurso_url(@recurso)
    assert_response :success
  end

  test 'deve atualizar recurso' do
    patch recurso_url(@recurso), params: recurso_update_params
    assert_redirected_to recursos_url
  end

  test 'deve mostrar erro ao atualizar recurso' do
    patch recurso_url(@recurso), params: { recurso: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar recurso' do
    assert_difference('Recurso.count', -1) do
      delete recurso_url(@recurso)
    end
    assert_redirected_to recursos_url
  end

  private

    def recurso_create_params
      {
        recurso: {
          nome: nil,
          descricao: nil,
          tipo: nil
        }
      }
    end

    def recurso_update_params
      {
        recurso: {
        }
      }
    end
end
