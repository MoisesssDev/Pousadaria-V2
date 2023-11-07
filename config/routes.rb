Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:new, :create]
  resources :rooms, only: [:new, :create, :edit, :update, :index]
  resources :guesthouses, only: [:new, :create, :show]
end
