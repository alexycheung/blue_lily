Rails.application.routes.draw do
	root to: 'users#index'

  devise_for :users
  resources :users

  resources :properties
  get '/properties/:id/assign', to: "properties#assign", as: 'assign'

  resources :items
  get '/items/:id/zoom', to: 'items#zoom', as: 'zoom'
  post '/items/:id/reserve', to: 'items#reserve', as: 'reserve'
  post '/items/:id/cancel_reservation', to: 'items#cancel_reservation', as: 'cancel_reservation'
  post '/items/:id/checkin', to: 'items#checkin', as: 'checkin'
  post '/items/:id/checkout', to: 'items#checkout', as: 'checkout'
end
