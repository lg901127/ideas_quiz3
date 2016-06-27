Rails.application.routes.draw do
  root "ideas#index"
  resources :ideas do
    resources :likes, only: [:create, :destroy]
    resources :memberships, only: [:create, :destroy]
    resources :comments
  end
  resources :users
  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end
end
