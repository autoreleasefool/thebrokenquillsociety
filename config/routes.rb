Rails.application.routes.draw do
  resources :works
  resources :users
  root 'works#index'
end
