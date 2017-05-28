Rails.application.routes.draw do
	root to: 'users#index'

  devise_for :users
  resources :users

  resources :properties

  resources :items
  get '/items/:id/zoom', to: 'items#zoom', as: 'zoom'
end
