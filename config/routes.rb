Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users,  controllers: {
        sessions: 'users/sessions',
        registrations: "users/registrations",
        passwords: "users/passwords",
        omniauth_callbacks: "users/omniauth_callbacks"
      }
  get 'books/search', to: 'books#search'
  resources :books, only: [:index, :show] do
    resources :dealings, only: [:new, :create]
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit]
  resources :addresses, only: :update
  root "books#index"
end
