require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }
  # let!(:user) do
  # # userが変数を表す
  #   User.create!({
  #     email: 'test@example.com',
  #     password: 'password'
  #   })
  # end
  # userは広く使用するので上の階層に移動　どちらのcontextでも使用できる
  context 'タイトルと内容が入力されている場合' do
    # articleが変数を表す
    # let使用時はインスタンス変数にしなくても良い
    let!(:article) { build(:article, user: user) }
    # let!(:article) do
    #   user.articles.build({
    #     title: Faker::Lorem.characters(number: 10),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end
    # context:前提条件を入れる時contextを入れた場合にbeforeを入れるのは規則
    # before do
    #   user = User.create!({
    #     email: 'test@example.com',
    #     password: 'password'
    #   })
    #   @article = user.articles.build({
    #     title: Faker::Lorem.characters(number: 10),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
      # it がアクセスできないのでインスタンス変数にする
      # 記事が有効であることを期待
      # bundle exec rspec spec/models/article_spec.rb
    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end
  
  context 'タイトルの文字が一文字の場合' do
    let!(:article) { build(:article, title: Faker::Lorem.characters(number: 1), user: user) }

    before do
      article.save
    end
      # さっきはクリエイトだったけど例外が発生してしまうのでbuildに
    # userはuserに紐づいている
    # let!(:article) do
    #   # user.articles.build({
    #   user.articles.create({
    #     title: Faker::Lorem.characters(number: 1),
    #     content: Faker::Lorem.characters(number: 300)
    #   })
    # end

    it '記事を保存できない' do
      expect(article.errors.messages[:title][0]).to eq('は2文字以上で入力してください')
      # タイトルに関するエラーメッセージ
      # 配列で渡ってくる０番目
      # メッセージの内容が次の内容と一緒だったら（eq）
      # このエラーメッセージはsaveとかcreateを実施した瞬間だけ
    end
  end
end
