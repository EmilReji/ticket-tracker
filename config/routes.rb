Rails.application.routes.draw do
  root to: "projects#index"

  resources :users

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :projects do
    resources :tickets, except: [:index]
  end

  resources :tickets, only: [:index]

  resources :tags, except: [:show]
end
