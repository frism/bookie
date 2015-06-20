Rails.application.routes.draw do

  root 'pages#index'

  resources :users
  resources :sessions

  resources :items
  resources :bookings do
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
