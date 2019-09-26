require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Sso < OmniAuth::Strategies::OAuth2
      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        site:  SSO_URL,
        authorize_url: "#{SSO_URL}/auth/sso/authorize",
        access_token_url: "#{SSO_URL}/auth/sso/access_token"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { raw_info['id'] }

      info do
        {
          username: raw_info['info']['username'],
          email: raw_info['info']['email']
        }
      end

      extra do
        {
          first_name: raw_info['extra']['first_name'],
          last_name: raw_info['extra']['last_name'],
          phone: raw_info['extra']['phone'],
          cpf: raw_info['extra']['cpf']
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/sso/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
