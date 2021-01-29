Rails.application.routes.draw do
  get "/" => "home#index"

  resources :users
  resources :menus

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_sessions

  get "/dashboard" => "dashboard#index", as: :dashboard
end
