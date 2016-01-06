Rails.application.routes.draw do

  root 'application#index'

  resources :works do
    resources :comments
  end

  resources :users
  resources :announcements
  resources :abouts

  # Application routes
  get '/search' => 'application#search'
  get '/about' => 'abouts#about', as: :about_club
  get '/admin' => 'application#admin', as: :admin_options

  # Routes to create a new account
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  # Routes to login to / logout of a user's account
  get '/login' => 'sessions#new', :as => :new_session
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # Route to access elements of user's profile
  get '/profile' => 'users#show'
  get '/faves' => 'users#faves'
  post '/like' => 'users#add_favourite'
  post '/unlike' => 'users#remove_favourite'

  # Route to enable/disable admin options
  post '/update_admin_options' => 'application#update_admin_options'
  patch '/update_admin_options' => 'application#update_admin_options'

  # Error pages
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code
  end

end
