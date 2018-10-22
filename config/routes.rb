Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'products#index', as: 'root'

  get "/auth/:provider/callback", to: "sessions#create", as: 'auth_callback'


  resources :orders, only: [:index, :show, :create, :update, :destroy] do
    resources :order_items, except: [:index, :show, :edit]
  end

  get '/checkout', to: 'orders#edit', as: 'checkout'

  get '/cart', to: 'orders#index', as: 'cart'

  resources :products, except: [:new, :create, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create, :index]
  end

  resources :categories, except: [:destroy] do
    resources :products, only: [:index]
  end

  resources :merchants, only: [:show] do
    resources :products, except: [:show, :destroy]
  end

  resources :sessions, only: [:new, :create]
  post '/sessions/logout', to: 'sessions#logout', as: 'logout'
end
