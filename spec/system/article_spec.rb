require 'rails_helper'

RSpec.describe 'Article', type: :system do
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) }
  # 記事は複数あるので複数形に

  it '記事一覧がひょうじされる' do
    visit root_path
    articles.each do |article|
      expect(page).to have_css('.card_title', text: article.title)
      # have.contentだと偶然テストが通ってしまう可能性がある
      # have.css classが存在しているかを確認するとともにclassの持っているタグのテキストがarticle.titleと一致するか
      # card_titleのなかにarticle.titleというtextがあるかないかを確認
    end

    # 3つ全てに対して確認したい場合はeach
    # titleという文字が存在しているかどうか
  end

  # クリックして記事が表示されるかをテスト
  it '記事詳細を表示できる' do
    visit root_path
    article = articles.first
    click_on article.title
    # click_on:カピバラで用意されている aタグをクリックしてくれる divタグとかには使えない
    # なぜ複数形？
    expect(page).to have_css('.article_title', text: article.title)
    expect(page).to have_css('.article_content', text: article.content.to_plain_text)
    # plain:文字列を出力
  end
end