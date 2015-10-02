Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index, :show, :update] do
    resources :galleries, except: [:index]
  end

  resources :photos
  resources :topics
  resources :events
  post 'events/:id/join', to: 'events#join', :as => :join_event

  resources :friendships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end
