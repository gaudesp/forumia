Rails.application.routes.draw do
  devise_for :users, 
    path: "",
    controllers: { registrations: 'users/registrations', sessions: 'users/sessions' },
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'setting' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'default#redirect'
  resources :home, only: [:index]
  resources :staff, only: [:index]
  resources :users, path: "profile", param: :username, only: [:show]
end
