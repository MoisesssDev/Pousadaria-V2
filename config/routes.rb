Rails.application.routes.draw do
  devise_for :clients, controllers: {
    sessions: 'clients/sessions',
    registrations: 'clients/registrations'
  }
  
  devise_for :owners
  
  root to: "home#index"

  resources :rooms, only: [:new, :create, :edit, :update, :index, :show] do
    resources :reservations, only: [:new, :create, :show]
    post '/check_availability', to: 'reservations#check_availability'
    patch '/cancel_reservation/:id', to: 'reservations#cancel', as: 'cancel_reservation'
  end

  resources :reservations, only: [:index] do
    resources :reviews, only: [:create, :show] do
      post '/response', to: 'reviews#response_to_review'
    end
    post '/check_in', to: 'reservations#check_in', as: 'check_in'
    post '/check_out', to: 'reservations#check_out', as: 'check_out'
  end

  resources :custom_prices, only: [:new, :create]
  
  resources :guesthouses, only: [:new, :create, :show, :edit, :update] do
    resources :reviews, only: [:index]
  end
  
  get '/active_stays', to: 'reservations#active_stays', as: 'active_stays'

  get 'guesthouses_by_city', to: 'guesthouses#by_city', as: :guesthouses_by_city

  get 'search_guesthouses', to: 'guesthouses#search', as: :search_guesthouses

  namespace :api do
    namespace :v1 do
      resources :guesthouses, only: [:index, :show]
      # resources :rooms, only: [:index, :show]
      # resources :reservations, only: [:index, :show, :create]
      # resources :reviews, only: [:index, :show, :create]
      # resources :custom_prices, only: [:index, :show]
    end
  end
end
