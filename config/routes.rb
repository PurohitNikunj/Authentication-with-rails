Rails.application.routes.draw do
  
  #Create New User 
  get '/signup', to: "users#new"
  post '/signup', to: "users#create"

  #Show logged-in user (private end-points)
  get '/show/', to: "users#show", as: "show"
  get '/index/', to: "users#index", as: "index"

  #Log-in user with JWT
  get '/login', to: "token_authentications#login"
  post '/login', to: "token_authentications#post_login"

end
