Rails.application.routes.draw do
  resources :works do
    resources :comments
  end

  resources :users
  resources :announcements
  resources :abouts

  root 'application#index'

  # Application routes
  get '/search' => 'application#search'
  get '/about' => 'about#index', as: :about_club

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Routes to login to / logout of a user's account
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Route to access elements of user's profile
  get '/profile' => 'users#show'
  get '/faves' => 'users#faves'
  post '/like' => 'users#add_favourite'
  post '/unlike' => 'users#remove_favourite'

end
