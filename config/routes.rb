Rails.application.routes.draw do

  root 'posts#index'

  resources :comments, :posts do
    resources :votes, except: [:new, :edit, :index, :show]
    resources :comments, except: [:show, :index]
  end

  get 'signup' => 'users#new'
  resources :users, only: [:new, :create]

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
