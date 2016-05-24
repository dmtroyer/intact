Rails.application.routes.draw do
  devise_for :users
  root 'hashed_strings#index'
  resources :hashed_strings, only: [:create, :destroy]
end
