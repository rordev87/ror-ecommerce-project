Rails.application.routes.draw do
  get 'user/sign_up'
  get 'user/sign_out'
  get 'user/login'
  get 'user/logout'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'

  root :to => "pages#home"
end
