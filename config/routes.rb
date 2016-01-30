Rails.application.routes.draw do
  root 'home#index'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'




  get '/sessions' => 'sessions#show'
  resources :users, :except => [:index, :destroy]

  resources :lists, :except => [:index] do
    resources :bookmarks
  end

  resources :upload, :only =>[:new, :create, :destroy]

end
