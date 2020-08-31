Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  resource :timeline, only: [:show]
  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :articles do
    resources :comments, only: [:new, :create]
    resource :like, only: [:create, :destroy]
    # いいねは一回だけだから単数系 複数にするときはIDを参照しなければならない
    # これを複数形にするとidを指定することになる
    # Like.find(params[:id]).destroyとなるが適当なIDを指定して削除することができる
  end

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    # destroyではない理由はURLが綺麗？消すのはおかしい？unfollow をcreateする RESTful
    # followのrelationshipを作るからcreate
  end
  # follow機能 アカウントの詳細ページをみて確認するのでshow

  resource :profile, only: [:show, :edit, :update]
  resources :favorites, only: [:index]
#  いいね
  # create,new,は不要

end

# articleの下にコメントがある形にする