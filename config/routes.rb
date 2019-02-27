Rails.application.routes.draw do
  root 'home#index'
  scope(path_names: { new: 'novo', edit: 'editar' }) do
    # Administracao
    resources :usuarios
    resources :permissoes
    resources :recursos
    resources :perfis
    resources :usuarios_perfis
  end

  devise_for :usuarios
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
