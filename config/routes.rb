Rails.application.routes.draw do
  root to:'tasks#index'
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks
end
