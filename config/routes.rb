Rails.application.routes.draw do
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'

  namespace :admin do
    # get '/home', to: 'static_pages#home'
    root to: 'dashboard#home'
    get    '/:model', to: 'model#index', as: 'table'
    get    '/:model/:id', to: 'model#show', as: 'row_table'
    get    '/:model/:id/edit', to: 'model#edit', as: 'edit_row_table'
    patch    '/:model/:id', to: 'model#update', as: 'update_row_table'
    delete    '/:model/:id', to: 'model#destroy', as: 'delete_row_table'
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
