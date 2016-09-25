Rails.application.routes.draw do
  devise_for :users
  
  #authenticated :user do
  #  root "users#show", as: :authenticated_root
  #end

  resources :users, only: [:show]

  root 'welcome#index'
end
