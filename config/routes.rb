Rails.application.routes.draw do
  devise_for :users
  root 'messages#index'
  resources :users, only: [:show, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update, :show]
  resources :messages, only: [:index]



end
