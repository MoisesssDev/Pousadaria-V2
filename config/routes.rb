Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:new, :create]
  resources :rooms, only: [:new, :create, :edit, :update, :index, :show]
  resources :custom_prices, only: [:new, :create]
  resources :guesthouses, only: [:new, :create, :show, :edit, :update]
end
