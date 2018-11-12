Rails.application.routes.draw do
  get 'users/create'
  get 'users/new'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons
  resources :users
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

  root :to => "pages#home"
end
