Rails.application.routes.draw do

  root 'posts#index'

  resources :comments, :posts do
    resources :votes, except: [:new, :edit, :index, :show]
    resources :comments, except: [:show, :index]
  end

  get 'myposts' => 'posts#index_users_posts'
  get 'mostpopular' => 'posts#popular_posts'

  get 'signup' => 'users#new'
  resources :users
  resources :images

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end
