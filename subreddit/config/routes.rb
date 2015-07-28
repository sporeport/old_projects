RedditClone::Application.routes.draw do
  root to: "sessions#new"

  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: [:new, :create]
  end
end
