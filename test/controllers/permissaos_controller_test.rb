require_relative 'application_test'

class PermissaosControllerTest < Admin::ApplicationTest
  setup do
    @permissao = permissaos(:permissao_0)
  end

  test 'deve listar permissaos' do
    get permissaos_url
    assert_response :success
  end

  test 'deve acessar novo permissao' do
    get new_permissao_url
    assert_response :success
  end

  test 'deve criar permissao' do
    assert_difference('Permissao.count') do
      post permissaos_url, params: permissao_create_params
    end
    assert_redirected_to permissaos_url
  end

  test 'deve mostrar erro ao criar permissao' do
    post permissaos_url, params: { permissao: permissao_create_params[:permissao].except(:CAMPO_OBRIGATORIO) }
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
    assert_redirected_to permissaos_url
  end

  test 'deve mostrar erro ao atualizar permissao' do
    patch permissao_url(@permissao), params: { permissao: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar permissao' do
    assert_difference('Permissao.count', -1) do
      delete permissao_url(@permissao)
    end
    assert_redirected_to permissaos_url
  end

  private

    def permissao_create_params
      {
        permissao: {
          recurso_id: nil,
          perfil_id: nil,
          visualizar: nil,
          criar: nil,
          atualizar: nil,
          excluir: nil
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
