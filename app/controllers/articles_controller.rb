class ArticlesController < ApplicationController
  # @article = Article.find(params[:id])は全てのアクションで実行しているため
  # before_actionとしてset_articleでまとめる
  before_action :set_article, only: [:show]
  # before_action :set_article, only: %i[show edit update]
  # editとupdateを削除
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  # ログインしていないと使えないauthenticate_user! new create edit update destroy
  # index new destroyでは実行する必要がないためonlyを入力する,

  def index
    @articles = Article.all
    # current_userログインしているユーザーのみに限定する
    # 関連ができている時はnewではなくbuildにして空の箱を作る
  end

  def show
    # @article = Article.find(params[:id])
    @comments = @article.comments
  end

  def new
    # @article = Article.new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end
      # noticeフラッシュメッセージ
      # article_paramsからcontentとtitleを持ってくる
      # データベースに値を保存するためsave
      # new.html.erbを指定して表示させようとしている
      # 保存に失敗した場合は、new.html.erbのform_withに基づいてデータを作成保存する。
      # Render.newとするのが基本
      # 成功したパターンと失敗した場合とで書き方が違う

  def edit
    @article = current_user.articles.find(params[:id])
    # @article = Article.find(params[:id])
    # 他人の記事が編集できないようにcurrent_userを入れる
    # ログインしているユーザーががそこからidを見つけて表示
  end

  def update
    # @article = Article.find(params[:id])
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
      # article_path 記事詳細ページ
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
      #  失敗時は編集画面にrenderする。
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
    # 削除されなければおかしいから処理を止める。
    # destroy はデータを削除するだけで何かを表示するわけではないためインスタンス変数としない
    # @articleとしていると慣習的にviewで表示されていると思われてしまう
  end

  private

  # strong parameter はprivateを必ずつける
  # article（モデル名）paramsというアクション名にする決まり
  def article_params
    params.require(:article).permit(:title, :content, :eyecatch)
  end
    # puts '----------------------------'
    # puts params
    # puts '----------------------------'
    # params.require(:article).permit(:title, :content)
    # articleというキーを持っていないと認めない。require:必須とする
    # permit 保存する対象を限定し許可する

  def set_article
    @article = Article.find(params[:id])
  end
end
