Rails.application.routes.draw do
  resources :works
  resources :users

  root 'works#index'

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Routes to access a user's account
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

end
