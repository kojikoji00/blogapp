Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :articles do
    resources :comments, only: [:new, :create]
  end
end

# articleの下にコメントがある形にする