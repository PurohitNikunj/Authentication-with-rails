Rails.application.routes.draw do
  
  #Create New User 
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  #Show logged-in user (private end-points)
  get '/show/', to: "users#show", as: "show"
  get '/index/', to: "users#index", as: "index"

  #Log-in & Log-out user
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  delete '/logoutall', to: "sessions#destroyall"

end
