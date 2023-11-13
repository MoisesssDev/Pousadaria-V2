Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users, only: [:new, :create]
  resources :rooms, only: [:new, :create, :edit, :update, :index, :show]
  resources :custom_prices, only: [:new, :create]
  resources :guesthouses, only: [:new, :create, :show, :edit, :update]
  get 'guesthouses_by_city', to: 'guesthouses#by_city', as: :guesthouses_by_city
  get 'search_guesthouses', to: 'guesthouses#search', as: :search_guesthouses
end
