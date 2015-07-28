Rails.application.routes.draw do
    root to: "root#root"
    resources :posts, defaults: {format: 'json'}, only: [:create, :show, :index, :update, :destroy]
end
