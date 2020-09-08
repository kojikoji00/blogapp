require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:user) { create(:user) }
  let(:articles) { create_list(:article, 3, user: user) }
  # 3個データを作る
  describe 'GET /articles' do
    it '200ステータスが返ってくる' do
      get articles_path
      # # コントローラーにリクエストを送ることができる
      # ゲットするとレスポンスが使える
      # httpステータスが200担っていればOK
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /articles' do
    # ログインしていないと失敗してしまうため追記
    # ただDeviseはRSpec環境に導入できていないためhelperにかく
    context 'ログインしている場合' do
      before do
        sign_in user
        # deviseのメソッド helperにDeviseに関する記載をすることで使用できる
      end
    # createでredirectを返すときは302が返ってくる
    # ただ記事が保存されずに返ってきているとまずいので302 が返ってきていることを確認したいわけではない
      it '記事が保存される' do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        # article_params経由でtitleとcontentを引っ張ってきている
        # # コントローラーにリクエストを送ることができる
        # ゲットするとレスポンスが使える
        # httpステータスが200担っていればOK
        expect(response).to have_http_status(302)
        expect(Article.last.title).to eq(article_params[:title])
        # expect(Article.last.content).to eq(article_params[:content])
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
      # インスタンスが返ってきてしまうので、文字列を取得するために修正
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end