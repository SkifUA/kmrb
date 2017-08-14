Rails.application.routes.draw do
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  get 'auth/:provider/callback', to: 'sessions#google_auth'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  namespace :admin do
    # get '/home', to: 'static_pages#home'
    root to: 'dashboard#home'
    get    '/:model/', to: 'models#index', as: 'model_rows'
    get    '/:model/new', to: 'models#new', as: 'new_model_row'
    post    '/:model/create', to: 'models#create', as: 'create_model_row'
    get    '/:model/:id', to: 'models#show', as: 'model_row'
    get    '/:model/:id/edit', to: 'models#edit', as: 'edit_model_row'
    patch    '/:model/:id', to: 'models#update', as: 'update_model_row'
    delete    '/:model/:id', to: 'models#destroy', as: 'delete_model_row'
  end

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
