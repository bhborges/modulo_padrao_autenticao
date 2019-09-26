Rails.application.config.middleware.use OmniAuth::Builder do
  provider :sso, 'D3A0244EC972817D214E', 'FDB19CF07741FB21D308206C788AF67FEC6A9778F4EF', scope: 'sso'
end
