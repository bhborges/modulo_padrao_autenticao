Rails.application.routes.draw do
  devise_for :usuarios

  root 'home#index'
  scope(path_names: { new: 'novo', edit: 'editar' }) do
    # Administracao
    resources :usuarios_perfis
    resources :permissoes
    resources :recursos
    resources :perfis
    resources :usuarios
  end

  # OmniAuth
  get 'auth/:provider/callback', to: 'auth#sso'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
