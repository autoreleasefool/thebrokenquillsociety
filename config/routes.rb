Rails.application.routes.draw do
  resources :works do
    resources :comments
  end

  resources :users
  resources :announcements

  root 'application#index'

  # Route to search
  get '/search' => 'application#search'

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Routes to login to / logout of a user's account
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Route to access elements of user's profile
  get '/profile' => 'users#show'
  get '/mine' => 'users#works'

end
