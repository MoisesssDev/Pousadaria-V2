Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:new, :create]
  resources :guesthouses, only: [:new, :create]
end
