require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
# レターオープナーに関する記述
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'articles#index'
  # resources :articles, only: [:show, :new, :create, :edit, :update, :destroy]
  # resources :articles do
  #   resources :comments, only: [:index, :new, :create]
  #   resource :like, only: [:show, :create, :destroy]
  resources :articles
    # いいねしているかしていないかを見るためshow
    # いいねは一回だけだから単数系 複数にするときはIDを参照しなければならない
    # これを複数形にするとidを指定することになる
    # Like.find(params[:id]).destroyとなるが適当なIDを指定して削除することができる

  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
    # destroyではない理由はURLが綺麗？消すのはおかしい？unfollow をcreateする RESTful
    # followのrelationshipを作るからcreate
  end
  # follow機能 アカウントの詳細ページをみて確認するのでshow

 

  scope module: :apps do
    resource :timeline, only: [:show]
    resource :profile, only: [:show, :edit, :update]
    resources :favorites, only: [:index]#  いいね
  end
  
  # create,new,は不要
  namespace :api, defaults: {format: :json} do
    scope '/articles/:article_id' do
      # namesapaceはurlとcontroller
    # urlだけを変えたいからscopeを使う
      resources :comments, only: [:index, :create]
      resource :like, only: [:show, :create, :destroy]
    # htmlでレスポンスを返すか、jsonで返すか指定できる.htmlか.jsonかAPI配下なのでjsonで返したい
    end
  end
end

# articleの下にコメントがある形にする