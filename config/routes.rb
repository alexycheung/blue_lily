Rails.application.routes.draw do
	root to: 'properties#index'

  devise_for :users
  resources :users

  resources :properties, except: [:show]
  get '/properties/:id/assign', to: 'properties#assign', as: 'assign_property'
  get '/properties/retrieve', to: 'properties#retrieve', as: 'retrieve_property'

  resources :items, except: [:show]
  get '/items/:id/zoom', to: 'items#zoom', as: 'zoom'
  post '/items/:id/reserve', to: 'items#reserve', as: 'reserve'
  post '/items/:id/cancel_reservation', to: 'items#cancel_reservation', as: 'cancel_reservation'
  post '/items/:id/checkin', to: 'items#checkin', as: 'checkin'
  post '/items/:id/reverse_checkin', to: 'items#reverse_checkin', as: 'reverse_checkin'
  post '/items/:id/checkout', to: 'items#checkout', as: 'checkout'
  post '/items/:id/reverse_checkout', to: 'items#reverse_checkout', as: 'reverse_checkout'

  get '/items/:id/reservations', to: 'reservations#index', as: 'reservations'

  resources :categories
end
