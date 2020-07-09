Rails.application.routes.draw do
  root to: "projects#index"

  resources :users

  get '/register', to: 'users#new'

  resources :projects do
    resources :tickets, except: [:index]
  end

  resources :tickets, only: [:index]

  resources :tags, except: [:show]
end
