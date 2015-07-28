GoalsProject::Application.routes.draw do
  resources :users

  resources :goals, only: [:create, :update]


  resource :session, only: [:new, :create, :destroy]

  root to: "sessions#new"
end
