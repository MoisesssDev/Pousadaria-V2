Rails.application.routes.draw do
  devise_for :clients
  devise_for :owners
  
  root to: "home#index"

  resources :rooms, only: [:new, :create, :edit, :update, :index, :show] do
    resources :reservations, only: [:new, :create]
  end

  resources :custom_prices, only: [:new, :create]
  
  resources :guesthouses, only: [:new, :create, :show, :edit, :update]
  
  get 'guesthouses_by_city', to: 'guesthouses#by_city', as: :guesthouses_by_city
  get 'search_guesthouses', to: 'guesthouses#search', as: :search_guesthouses
  post '/reservations/:room_id/check_availability', to: 'reservations#check_availability', as: :check_availability
end
