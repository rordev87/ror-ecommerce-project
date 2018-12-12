Rails.application.routes.draw do
  devise_for :order_items
  devise_for :orders
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :weapons, only: [:index, :show] do
    member do
<<<<<<< HEAD
      post :add_to_cart, :remove_item_from_cart, :increase_cart_item_quantity, :decrease_cart_item_quantity
    end
    collection do
      post :remove_all_from_cart, :place_order
=======
      post :add_to_cart
    end
    collection do
      post :remove_from_cart
>>>>>>> c8e0775f412cce674971b314da53e2d873e3689f
    end
  end

  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  get '/cart', to: 'pages#cart'
  get '/checkout', to: 'pages#checkout'

  root :to => "pages#home"
end
