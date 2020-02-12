Rails.application.routes.draw do
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy]
  get '/', to: 'posts#index', as: 'root'
end
