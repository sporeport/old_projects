MusicApp::Application.routes.draw do
  root to: "users#index"

  resource :session, only: [:create, :destroy, :new]

  resources :users

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :show, :update, :destroy]
end
