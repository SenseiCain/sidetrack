Rails.application.routes.draw do
  get '/', to: 'posts#index', as: 'root'
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy], path: 'p'
  
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]

  resources :comments, only: [:create, :destroy]
  resources :votes, only: [:create]
  resources :users, only: [:show, :create, :new], path: 'u'
end
