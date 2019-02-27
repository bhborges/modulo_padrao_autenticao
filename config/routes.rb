Rails.application.routes.draw do
  resources :usuario_perfis
  resources :permissoes
  resources :recursos
  resources :perfis
  resources :odisseias
  root 'home#index'

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
