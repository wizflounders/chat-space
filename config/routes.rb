Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :users, only: [:show, :edit, :update]
  resources :groups, except: [:index, :destroy]
  resources :messages, only: [:index, :create]
end
