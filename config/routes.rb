Rails.application.routes.draw do

  root 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  get 'signup' => 'users#new'
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
