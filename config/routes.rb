Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index, :show, :update] do
    resources :galleries, except: [:index]
  end

  resources :photos
  resources :topics
  resources :events

  resources :friendships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'
end
