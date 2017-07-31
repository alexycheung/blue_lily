Rails.application.routes.draw do
	root to: 'properties#index'

  devise_for :users
  resources :users

  resources :properties, except: [:show] do
    resources :photos
  end
  get '/properties/:id/assign', to: 'properties#assign', as: 'assign_property'
  get '/properties/retrieve', to: 'properties#retrieve', as: 'retrieve_property'
  get '/properties/zillow', to: 'properties#zillow', as: 'zillow_property'
  get '/properties/:id/barcodes', to: 'properties#barcodes', as: 'barcodes_property'

  resources :items, except: [:show] do
    resources :units
  end
  get '/items/:id/zoom', to: 'items#zoom', as: 'zoom'
  get '/items/:id/barcode', to: 'items#barcode', as: 'barcode_item'

  resources :reservations, only: [:create, :index, :destroy]
  get '/reservations/manage_checkin', to: 'reservations#manage_checkin', as: 'manage_checkin_reservations'
  post '/reservations/checkin', to: 'reservations#checkin', as: 'checkin_reservations'
  get '/reservations/manage_checkout', to: 'reservations#manage_checkout', as: 'manage_checkout_reservations'
  post '/reservations/checkout', to: 'reservations#checkout', as: 'checkout_reservations'

  resources :categories

  resources :versions, only: [:index]
  post '/versions/:id/undo', to: 'versions#undo', as: 'undo_version'

  resources :vendors
end
