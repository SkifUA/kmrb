Rails.application.routes.draw do

  namespace :admin do
    get 'user/index'
  end

  namespace :admin do
    get 'user/edit'
  end

  namespace :admin do
    get 'user/show'
  end

  namespace :admin do
    get 'user/update'
  end

  namespace :admin do
    get 'user/destroy'
  end

  namespace :admin do
    get 'base/index'
  end

  namespace :admin do

    resources :users

    root to: 'base#index'
  end


  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#home'

  get '/signup', to: 'users#new'
  resources :users
  resources :account_activations, only: [:edit]

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :password_resets,     only: [:new, :create, :edit, :update]
end
