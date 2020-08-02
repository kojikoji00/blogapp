class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # article_paramsからcontentとtitleを持ってくる
    # データベースに値を保存するためsave
    if @article.save
      redirect_to article_path(@article), notice: '保存できたよ'
      # noticeフラッシュメッセージ
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
      # new.html.erbを指定して表示させようとしている
      # 保存に失敗した場合は、new.html.erbのform_withに基づいてデータを作成保存する。
      # Render.newとするのが基本
      # 成功したパターンと失敗した場合とで書き方が違う
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新できました'
      # article_path 記事詳細ページ
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
      #  失敗時は編集画面にrenderする。
    end
  end


  private
  # strong parameter はprivateを必ずつける
  # article（モデル名）paramsというアクション名にする決まり
  def article_params
    puts '----------------------------'
    puts params
    puts '----------------------------'
    params.require(:article).permit(:title, :content)
    # articleというキーを持っていないと認めない。require:必須とする
    # permit 保存する対象を限定し許可する

  end
end