Rails.application.routes.draw do
  namespace :admin do
  	resources :dashboards
  	resources :posts
  	resources :users
  end
  devise_for :users, controllers: {sessions: "sessions", registrations: "registrations"}

  root 'home#index'
	resources :posts
end
