require_relative 'application_test'

class PerfilsControllerTest < Admin::ApplicationTest
  setup do
    @perfil = perfils(:perfil_0)
  end

  test 'deve listar perfils' do
    get perfils_url
    assert_response :success
  end

  test 'deve acessar novo perfil' do
    get new_perfil_url
    assert_response :success
  end

  test 'deve criar perfil' do
    assert_difference('Perfil.count') do
      post perfils_url, params: perfil_create_params
    end
    assert_redirected_to perfils_url
  end

  test 'deve mostrar erro ao criar perfil' do
    post perfils_url, params: { perfil: perfil_create_params[:perfil].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar perfil' do
    get perfil_url(@perfil)
    assert_response :success
  end

  test 'deve editar perfil' do
    get edit_perfil_url(@perfil)
    assert_response :success
  end

  test 'deve atualizar perfil' do
    patch perfil_url(@perfil), params: perfil_update_params
    assert_redirected_to perfils_url
  end

  test 'deve mostrar erro ao atualizar perfil' do
    patch perfil_url(@perfil), params: { perfil: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar perfil' do
    assert_difference('Perfil.count', -1) do
      delete perfil_url(@perfil)
    end
    assert_redirected_to perfils_url
  end

  private

    def perfil_create_params
      {
        perfil: {
          descricao: nil
        }
      }
    end

    def perfil_update_params
      {
        perfil: {
        }
      }
    end
end
