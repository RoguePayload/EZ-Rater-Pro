Rails.application.routes.draw do

  # Set Project Home Page #
  root 'static_pages#home'

  # Set Project STatic Pages #
  get '/help',  to: 'static_pages#help'
  get '/about',  to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # Set Users Paths #
  get '/signup',  to: 'users#new'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"


  # Set Project Resources #
  resources :users
end
