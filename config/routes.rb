Rails.application.routes.draw do
  resources :usuarios_perfis
  resources :permissoes
  resources :recursos
  resources :perfis
  devise_for :usuarios
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
