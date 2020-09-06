class Api::LikesController < Api::ApplicationController
  before_action :authenticate_user!
  # ログインしてからしかできない
  def show
    article = Article.find(params[:article_id])
    like_status = current_user.has_liked?(article)
    render json: {hasLiked: like_status}
    # renderは何か描画するために行う 今まではデフォルトでやっていた
  # レスポンスとしてjavascriptに返ってくる javascriptではキャメルケースでかく
  end

  def create
    article = Article.find(params[:article_id])
    article.likes.create!(user_id: current_user.id)
    # 必ず保存されているはず
    render json: { status: 'ok' }
    # redirect_to article_path(article)
    # jsonでやるからredirectしなくていい
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
    # redirect_to article_path(article)
    render json: { status: 'ok' }
  end
  # 絶対に見つけないといけないのでfind_byにもびっくりマークつける
end