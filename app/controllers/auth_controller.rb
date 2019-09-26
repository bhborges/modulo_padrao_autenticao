class AuthController < ApplicationController
  skip_before_action :verificar_login!
  # GET /auth/:provider
  def sso
    p 'teste2'
    callback_url = session[:callback_url]
    session[:oauth_token] = auth_hash.credentials.token
    session[:oauth_expires_at] = Time.at(auth_hash.credentials.expires_at)

    @usuario = Usuario.from_omniauth(auth_hash)

    redirect_to callback_url if sign_in(@usuario)
    # else
    #   render html: 'Falha na autenticação!'
    # end
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
