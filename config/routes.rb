#require 'sidekiq/web'
Rails.application.routes.draw do
  
  resources :facilities do
  	collection do
      post 'search'
    end
  end
  
  root to: "home#index"
  
  devise_for :users
 
  resources :rooms, controller: 'admin/rooms'
  resources :bookings
  
  #mount Sidekiq::Web, at: '/sidekiq'
end
