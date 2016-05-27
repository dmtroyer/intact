Rails.application.routes.draw do
  devise_for :users
  resources :hashed_strings, only: [:create, :destroy]

  authenticated :user do
    root 'hashed_strings#index', as: :authenticated_root
  end
  root to: redirect('/users/sign_in')
end
