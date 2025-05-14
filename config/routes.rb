Rails.application.routes.draw do
  resources :order_dishes
  resources :orders
  resources :cart_dishes, only: [:update]

   resources :carts, only: [:show, :create, :update, :destroy] do
    post 'add_to_cart', on: :member
  end

  resources :dish_ingredients

  resources :cart_dishes, only: [:destroy] do
    patch :update_quantity, on: :member
    end

  resources :ingredients

  resources :dishes

  devise_for :users, controllers: { 
      sessions: 'users/sessions', 
      registrations: 'users/registrations'
    }

  get "up" => "rails/health#show", as: :rails_health_check


  root "dishes#index"
end
