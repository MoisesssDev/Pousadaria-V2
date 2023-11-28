Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions'
  }
  
  devise_for :owners
  
  root to: "home#index"

  resources :rooms, only: [:new, :create, :edit, :update, :index, :show] do
    resources :reservations, only: [:new, :create, :show]
    post '/check_availability', to: 'reservations#check_availability'
    patch '/cancel_reservation/:id', to: 'reservations#cancel', as: 'cancel_reservation'
  end

  resources :reservations, only: [:index]

  resources :custom_prices, only: [:new, :create]
  
  resources :guesthouses, only: [:new, :create, :show, :edit, :update]
  
  get 'guesthouses_by_city', to: 'guesthouses#by_city', as: :guesthouses_by_city
  get 'search_guesthouses', to: 'guesthouses#search', as: :search_guesthouses
end
