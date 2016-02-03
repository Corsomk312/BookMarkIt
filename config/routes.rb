Rails.application.routes.draw do
  # root 'display_bookmarks#show'

  root 'home#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'logout' => 'sessions#demolish'
  post 'extension/login' => 'extension#create' #, :defaults => { :format => 'json'}
  get 'extension/login' => 'extension#new'
  post 'extension/lists' => 'extension#show'
  post 'extension/bookmark' => 'extension#new_bookmark'

  get 'display_bookmarks' => 'display_bookmarks#show'

  # get '/sessions' => 'sessions#show'
  # (why did we have that?)

  resources :users, :except => [:destroy] do
    member do
      get :following, :followers
    end
  end

  resources :lists, :except => [:index] do
    resources :bookmarks
    resources :saved_bookmarks, :only => [:destroy]
  end

  resources :upload, :only =>[:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

end
