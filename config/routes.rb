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
  post '/items/:id/reverse_checkin', to: 'items#reverse_checkin', as: 'reverse_checkin'
  post '/items/:id/checkout', to: 'items#checkout', as: 'checkout'
  post '/items/:id/reverse_checkout', to: 'items#reverse_checkout', as: 'reverse_checkout'
end
