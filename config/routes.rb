Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "wikis#index", as: :authenticated_root
  end

  resources :users, only: [:show] do
    resources :wikis, except: [:index]
  end

  resources :wikis, only: [:index]

  resources :charges, only: [:new, :create, :destroy]

  root 'welcome#index'
end
