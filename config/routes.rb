Rails.application.routes.draw do
  get "/" => "home#index"

  resources :users
  resources :menus
  resources :orders

  post "/menu_items" => "menu_items#create", as: :menu_items
  post "/order_items" => "order_items#create", as: :order_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_sessions

  get "/dashboard" => "dashboard#index", as: :dashboard
end
