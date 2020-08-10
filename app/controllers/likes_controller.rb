class LikesController < ApplicationController
  before_action :authenticate_user!
  # ログインしてからしかできない

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id)
    redirect_to article_path(article)
    # hasmanyの関係になっているためできる
    # articleから作成しているからarticle_idはある。
    # user_idだけが無いから指定する
    # current_userはユーザーが入力するものでは無いので絶対保存される。保存されなければバグなので!をつける
    # いいねできたら同じ画面に戻ってくる
  end

  def destroy
    article = Article.find(params[:article_id])
    like = article.likes.find_by!(user_id: current_user.id)
    like.destroy!
    redirect_to article_path(article)
  end
  # 絶対に見つけないといけないのでfind_byにもびっくりマークつける
end