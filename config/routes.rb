Rails.application.routes.draw do

  root 'application#index'

  # Enabling devise
  devise_for :users

  resources :works do
    resources :comments
  end

  resources :users
  resources :announcements
  resources :abouts

  # Application routes
  get '/search' => 'application#search'
  get '/about' => 'abouts#about', as: :about_club

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

  devise_for :users, :skip => [:sessions]
  as :user do
    get 'sign-in' => 'devise/sessions#new', :as => :new_user_session
    post 'sign-in' => 'devise/sessions#create', :as => :user_session
    delete 'sign-out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

end
