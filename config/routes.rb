Rails.application.routes.draw do
  resources :works do
    resources :comments
  end

  resources :users

  root 'application#index'

  # Route to search
  get '/search' => 'works#search'

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Alternate route to see a user's profile
  get '/profile' => 'users#show'

  # Routes to login to / logout of a user's account
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Route to access current user's works
  get '/mine' => 'users#works'

end
