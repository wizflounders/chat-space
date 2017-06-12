Rails.application.routes.draw do
  devise_for :users
  root 'groups#index'
  resources :users, except: [:destroy, :create, :new] 
  resources :groups, except: [:destroy, :show] do
    resources :messages, only: [:index, :create]
  end
end
