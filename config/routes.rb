Rails.application.routes.draw do
  
  devise_for :users
  resources :coops
  resources :chickens do
    resources :eggs
  end
  
  resources :users do
    resources :subscriptions, only: [:new, :create]
  end

  get "/users/:user_id/subscriptions/manage", to: "subscriptions#manage"
  delete "/users/:user_id/subscriptions/cancel", to: "subscriptions#cancel", as: "cancel_user_subscription"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "app_pages#home"

  post "/api/webhooks/stripe", to: "api/webhooks/stripe#webhook"
end
