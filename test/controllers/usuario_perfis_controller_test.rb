require_relative 'application_test'

class UsuarioPerfisControllerTest < Admin::ApplicationTest
  setup do
    @usuarioperfil = usuarioperfis(:usuarioperfil_0)
  end

  test 'deve listar usuarioperfis' do
    get usuario_perfis_url
    assert_response :success
  end

  test 'deve acessar novo usuarioperfil' do
    get new_usuario_perfil_url
    assert_response :success
  end

  test 'deve criar usuarioperfil' do
    assert_difference('UsuarioPerfil.count') do
      post usuario_perfis_url, params: usuarioperfil_create_params
    end
    assert_redirected_to usuario_perfis_url
  end

  test 'deve mostrar erro ao criar usuarioperfil' do
    post usuario_perfis_url, params: { usuarioperfil: usuarioperfil_create_params[:usuarioperfil].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar usuarioperfil' do
    get usuario_perfil_url(@usuario_perfil)
    assert_response :success
  end

  test 'deve editar usuarioperfil' do
    get edit_usuario_perfil_url(@usuario_perfil)
    assert_response :success
  end

  test 'deve atualizar usuarioperfil' do
    patch usuario_perfil_url(@usuario_perfil), params: usuarioperfil_update_params
    assert_redirected_to usuario_perfis_url
  end

  test 'deve mostrar erro ao atualizar usuarioperfil' do
    patch usuario_perfil_url(@usuario_perfil), params: { usuarioperfil: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar usuarioperfil' do
    assert_difference('UsuarioPerfil.count', -1) do
      delete usuario_perfil_url(@usuario_perfil)
    end
    assert_redirected_to usuario_perfis_url
  end

  private

    def usuarioperfil_create_params
      {
        usuarioperfil: {
          usuarios_id: nil,
          perfis_id: nil
        }
      }
    end

    def usuarioperfil_update_params
      {
        usuarioperfil: {
        }
      }
    end
end
