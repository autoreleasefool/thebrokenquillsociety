Rails.application.routes.draw do
  resources :works do
    resources :comments
  end
  
  resources :users

  root 'works#index'

  # Route to search
  get '/search' => 'works#search'

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/profile' => 'users#show'

  # Routes to access a user's account
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
