Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'users#home'

  get '/signup', to: 'users#new'
  resources :users
  resources :account_activations, only: [:edit]

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :password_resets,     only: [:new, :create, :edit, :update]
end
