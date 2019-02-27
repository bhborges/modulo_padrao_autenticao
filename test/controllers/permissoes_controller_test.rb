require_relative 'application_test'

class PermissoesControllerTest < Admin::ApplicationTest
  setup do
    @permissao = permissoes(:permissao_0)
  end

  test 'deve listar permissoes' do
    get permissoes_url
    assert_response :success
  end

  test 'deve acessar novo permissao' do
    get new_permissao_url
    assert_response :success
  end

  test 'deve criar permissao' do
    assert_difference('Permissao.count') do
      post permissoes_url, params: permissao_create_params
    end
    assert_redirected_to permissoes_url
  end

  test 'deve mostrar erro ao criar permissao' do
    post permissoes_url, params: { permissao: permissao_create_params[:permissao].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar permissao' do
    get permissao_url(@permissao)
    assert_response :success
  end

  test 'deve editar permissao' do
    get edit_permissao_url(@permissao)
    assert_response :success
  end

  test 'deve atualizar permissao' do
    patch permissao_url(@permissao), params: permissao_update_params
    assert_redirected_to permissoes_url
  end

  test 'deve mostrar erro ao atualizar permissao' do
    patch permissao_url(@permissao), params: { permissao: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar permissao' do
    assert_difference('Permissao.count', -1) do
      delete permissao_url(@permissao)
    end
    assert_redirected_to permissoes_url
  end

  private

    def permissao_create_params
      {
        permissao: {
          recursos_id: nil,
          perfis_id: nil
        }
      }
    end

    def permissao_update_params
      {
        permissao: {
        }
      }
    end
end
