Rails.application.routes.draw do
	root to: 'properties#index'

  devise_for :users
  resources :users

  resources :properties, except: [:show]
  get '/properties/:id/assign', to: 'properties#assign', as: 'assign_property'
  get '/properties/retrieve', to: 'properties#retrieve', as: 'retrieve_property'
  get '/properties/zillow', to: 'properties#zillow', as: 'zillow_property'
  get '/properties/:id/barcodes', to: 'properties#barcodes', as: 'barcodes_property'

  resources :items, except: [:show]
  get '/items/:id/zoom', to: 'items#zoom', as: 'zoom'
  post '/items/:id/reserve', to: 'items#reserve', as: 'reserve'
  post '/items/:id/cancel_reservation', to: 'items#cancel_reservation', as: 'cancel_reservation'
  get '/items/:id/reservations', to: 'reservations#index', as: 'reservations'
  get '/items/manage_checkin', to: 'items#manage_checkin', as: 'manage_checkin_items'
  post '/items/checkin', to: 'items#checkin', as: 'checkin_item'
  get '/items/manage_checkout', to: 'items#manage_checkout', as: 'manage_checkout_items'
  post '/items/checkout', to: 'items#checkout', as: 'checkout_item'


  resources :categories
end
