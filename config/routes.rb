Rails.application.routes.draw do
  devise_for :users, 
    path: "",
    controllers: { registrations: 'users/registrations', sessions: 'users/sessions' },
    path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register', edit: 'setting' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/preview', to: 'messages#preview'
  get '/quote', to: 'messages#quote'
  resources :home, only: [:index]
  resources :notifications do
    member do
      patch 'mark_as_read', to: 'notifications#mark_as_read'
    end
  end
  resources :forums, path: "forum", only: [:index, :show, :new, :create, :edit, :update] do
    collection do
      get 'panel', to: 'forums#panel', as: :panel
    end
    resources :topics, path: "topic" do
      resources :messages, path: "message"
    end
  end
  resources :categories do
    collection do
      get 'panel', to: 'categories#panel', as: :panel
    end
  end
  resources :staff, only: [:index, :new, :create, :edit, :update] do
    collection do
      post 'promote', to: 'staff#promote', as: :promote
      get 'demote/:id', to: 'staff#demote', as: :demote
      get 'panel', to: 'staff#panel', as: :panel
    end
  end
  resources :users, path: "profile", param: :username, only: [:show]
end
