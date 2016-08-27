Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users,  controllers: {
        sessions: 'users/sessions',
        registrations: "users/registrations"
      }
  get 'books/search', to: 'books#search'
  resources :books, only: [:index, :show] do
    resources :dealings, only: [:new, :create]
  end
  resources :users, only: :show
  resources :addresses, only: :update
  root "books#index"
end
