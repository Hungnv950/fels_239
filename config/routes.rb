Rails.application.routes.draw do
  root "pages#index"
  get "/admin", to: "admin#index"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/words", to: "categories#words"

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :account_activations, only: :edit
  resources :relationships, only: [:create, :destroy]
  namespace :admin do
    resources :categories
    resources :words
    resources :answers, only: :destroy
    resources :users
    resources :answers, only: :destroy
    resources :users
  end
  resources :pages
  resources :categories
  resources :lessons
end
