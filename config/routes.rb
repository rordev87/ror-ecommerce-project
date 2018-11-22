Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons, only: [:index, :show] do
    member do
      post :add_to_cart
    end
    collection do
      post :remove_from_cart
    end
  end

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/cart', to: 'pages#cart'
  get '/checkout', to: 'pages#checkout'

  root :to => "pages#home"
end
