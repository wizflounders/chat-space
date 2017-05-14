Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  root 'messages#index'

  resources :messages
end
