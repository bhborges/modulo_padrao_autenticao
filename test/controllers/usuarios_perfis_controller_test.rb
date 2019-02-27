require_relative 'application_test'

class UsuariosPerfisControllerTest < Admin::ApplicationTest
  setup do
    @usuarioperfil = usuariosperfis(:usuarioperfil_0)
  end

  test 'deve listar usuariosperfis' do
    get usuarios_perfis_url
    assert_response :success
  end

  test 'deve acessar novo usuarioperfil' do
    get new_usuario_perfil_url
    assert_response :success
  end

  test 'deve criar usuarioperfil' do
    assert_difference('UsuarioPerfil.count') do
      post usuarios_perfis_url, params: usuarioperfil_create_params
    end
    assert_redirected_to usuarios_perfis_url
  end

  test 'deve mostrar erro ao criar usuarioperfil' do
    post usuarios_perfis_url, params: { usuarioperfil: usuarioperfil_create_params[:usuarioperfil].except(:CAMPO_OBRIGATORIO) }
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
    assert_redirected_to usuarios_perfis_url
  end

  test 'deve mostrar erro ao atualizar usuarioperfil' do
    patch usuario_perfil_url(@usuario_perfil), params: { usuarioperfil: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar usuarioperfil' do
    assert_difference('UsuarioPerfil.count', -1) do
      delete usuario_perfil_url(@usuario_perfil)
    end
    assert_redirected_to usuarios_perfis_url
  end

  private

    def usuarioperfil_create_params
      {
        usuarioperfil: {
          usuario_id: nil,
          perfil_id: nil
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
