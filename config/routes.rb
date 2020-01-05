Rails.application.routes.draw do
  devise_for :users, 
    path: "",
    controllers: { registrations: 'users/registrations', sessions: 'users/sessions' },
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'setting' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resources :home, only: [:index]
  resources :forums, only: [:index, :show, :new, :create, :edit, :update]
  resources :staff, only: [:index, :new, :create, :edit, :update] do
    collection do
      post 'promote', to: 'staff#promote', as: :promote
      get 'demote/:id', to: 'staff#demote', as: :demote
      get 'roles', to: 'staff#roles', as: :roles
    end
  end
  resources :users, path: "profile", param: :username, only: [:show]
end
