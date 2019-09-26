require_relative 'application_test'

class UsuariosControllerTest < ApplicationTest
  setup do
    @usuario = usuarios(:usuario_0)
  end

  test 'deve listar usuarios' do
    get usuarios_url
    assert_response :success
  end

  test 'deve acessar novo usuario' do
    get new_usuario_url
    assert_response :success
  end

  test 'deve criar usuario' do
    assert_difference('Usuario.count') do
      post usuarios_url, params: usuario_create_params
    end
    assert_redirected_to usuarios_url
  end

  test 'deve mostrar erro ao criar usuario' do
    post usuarios_url, params: { usuario: usuario_create_params[:usuario].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar usuario' do
    get usuario_url(@usuario)
    assert_response :success
  end

  test 'deve editar usuario' do
    get edit_usuario_url(@usuario)
    assert_response :success
  end

  test 'deve atualizar usuario' do
    patch usuario_url(@usuario), params: usuario_update_params
    assert_redirected_to usuarios_url
  end

  test 'deve mostrar erro ao atualizar usuario' do
    patch usuario_url(@usuario), params: { usuario: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar usuario' do
    assert_difference('Usuario.count', -1) do
      delete usuario_url(@usuario)
    end
    assert_redirected_to usuarios_url
  end

  private

    def usuario_create_params
      {
        usuario: {
          nome: nil,
          login: nil
        }
      }
    end

    def usuario_update_params
      {
        usuario: {
        }
      }
    end
end
