Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/checkout' to: 'pages#checkout'

  root :to => "pages#home"
end
