Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'projects#index'

  resources :projects
  resources :tasks

end
