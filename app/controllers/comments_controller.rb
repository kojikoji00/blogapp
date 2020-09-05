class CommentsController < ApplicationController
  # controller名は複数形を使う
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end
  # 下のarticleに渡すからインスタンス変数ではない？
# indexを追加
  def index
    article = Article.find(params[:article_id])
    comments = article.comments
    render json: comments
  end

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    @comment.save!

    render json: @comment
    #   redirect_to article_path(article), notice: 'コメントを追加'
    # else
    #   flash.now[:error] = '更新できませんでした'
    #   render :new
    # end
  end
  # 必ず保存できることを想定しているのでif文いらない
  # javascript適用することでいらなくなる
  # comment_paramsを使ってbuild

# POST?
# 保存されなかったことも考えてif文にする
# render :newで＠articleを使うからインスタンス変数にする

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end

# ストロングパラメーターコメントの中のコンテントについてしか保存しない
# セキュリティーのため