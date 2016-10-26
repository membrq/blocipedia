Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "wikis#index", as: :authenticated_root
  end

  resources :users, only: [:show] do
    resources :wikis, except: [:index]
  end

  #resources :wikis, only: [:index]

  resources :wikis, only: [:index] do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :charges, only: [:new, :create, :destroy]

  root 'welcome#index'
end
