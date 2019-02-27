require_relative 'application_test'

class OdisseiasControllerTest < Admin::ApplicationTest
  setup do
    @odisseia = odisseias(:odisseia_0)
  end

  test 'deve listar odisseias' do
    get odisseias_url
    assert_response :success
  end

  test 'deve acessar novo odisseia' do
    get new_odisseia_url
    assert_response :success
  end

  test 'deve criar odisseia' do
    assert_difference('Odisseia.count') do
      post odisseias_url, params: odisseia_create_params
    end
    assert_redirected_to odisseias_url
  end

  test 'deve mostrar erro ao criar odisseia' do
    post odisseias_url, params: { odisseia: odisseia_create_params[:odisseia].except(:CAMPO_OBRIGATORIO) }
    assert_response :success
  end

  test 'deve visualizar odisseia' do
    get odisseia_url(@odisseia)
    assert_response :success
  end

  test 'deve editar odisseia' do
    get edit_odisseia_url(@odisseia)
    assert_response :success
  end

  test 'deve atualizar odisseia' do
    patch odisseia_url(@odisseia), params: odisseia_update_params
    assert_redirected_to odisseias_url
  end

  test 'deve mostrar erro ao atualizar odisseia' do
    patch odisseia_url(@odisseia), params: { odisseia: { CAMPO_OBRIGATORIO: nil } }
    assert_response :success
  end

  test 'deve deletar odisseia' do
    assert_difference('Odisseia.count', -1) do
      delete odisseia_url(@odisseia)
    end
    assert_redirected_to odisseias_url
  end

  private

    def odisseia_create_params
      {
        odisseia: {
          texto: nil,
          fonte: nil
        }
      }
    end

    def odisseia_update_params
      {
        odisseia: {
        }
      }
    end
end
