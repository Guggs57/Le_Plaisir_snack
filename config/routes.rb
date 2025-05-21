Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get "home/index"
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users

  resource :profile, only: [:show, :edit, :update, :destroy]

  resources :orders do
    member do
      post :checkout
    end
  end

  resources :order_dishes

  resources :cart_dishes, only: [:index, :show, :edit, :update, :destroy] do
    patch :update_quantity, on: :member
  end

  resources :carts, only: [:show, :create, :update, :destroy] do
    post :add_to_cart, on: :member
  end

  resources :dish_ingredients
  resources :ingredients
  resources :dishes
end
