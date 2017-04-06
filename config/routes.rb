Rails.application.routes.draw do

  namespace :api do 
    namespace :v1 do  

      # /api/v1/users
      resources :users, only: [:create]

      # /api/v1/auth
      post '/auth', to: "auth#login"
    end
  end
end
