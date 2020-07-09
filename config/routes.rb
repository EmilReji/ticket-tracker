Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "projects#index"

  resources :projects do
    resources :tickets, except: [:index]
  end

  resources :tickets, only: [:index]

  resources :tags, except: [:show]
end
