Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

  root :to => "pages#home"
end
