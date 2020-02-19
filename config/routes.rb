Rails.application.routes.draw do
  get '/', to: 'posts#index', as: 'root'
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy]
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"

  resources :comments, only: [:create]

  resources :votes, only: [:create]
end
