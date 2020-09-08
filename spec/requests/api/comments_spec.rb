require 'rails_helper'
# APIのテスト
RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comments) { create_list(:comment, 3, article: article) }
  # userと記事とコメントにテストが必要
  # 複数のときはcreate_list

  describe 'GET /api/comments' do
    it '200 Status' do
      get api_comments_path(article_id: article.id)
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
    end
    # APIの場合はResponseを細かくチェックできる
  end
end
