Rails.application.routes.draw do
  devise_for :users
  root "books#index"
  resources :books, only: [:index, :show] do
    resources :dealings, only: [:new, :create]
  end
  resources :users, only: :show
end
