class CommentsController < ApplicationController
  # controller名は複数形を使う
  def new
    article = Article.find(params[:article_id])
    @comment = article.comments.build
  end
  # 下のarticleに渡すからインスタンス変数ではない？

  def create
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      redirect_to article_path(article), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new
    end
  end
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