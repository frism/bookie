Rails.application.routes.draw do

  root 'pages#index'

  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]

  resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :bookings, only: [:index, :new, :create, :edit, :update, :destroy] do
    member do
      patch :set_close
      patch :set_open
    end
  end

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'pages/booking', path: '/my-bookings'

end
