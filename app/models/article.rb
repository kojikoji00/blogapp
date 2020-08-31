# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  has_one_attached :eyecatch
  # アイキャッチの設定
  has_rich_text :content
  # エディターの強化 create_action_text →既存のテキストを消す必要がある
  # rails g migrateion RemoveContentFromArticles
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  # validates :content, length: { minimum: 10 }
  # validates :content, uniqueness: true
  # validate :validate_title_and_content_length
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # 記事が消えたらコメントも消える
  belongs_to :user
  # validateは独自ルール
  # presence 入力されていない場合は保存しない
  # 一人のユーザーにしか紐づかないので単数形userで書く
  # commentと紐付ける

  # def display_created_at
  #   I18n.l(created_at, format: :default)
  # end
  #   # I18n.l(@article.created_at, format: :default)
  #   # articleクラスのインスタンスだからそのクラスに定義されているメソッドを使える
  #   # articleはselfで取得している

  # def author_name
  #   user.display_name
  # end

  # def like_count
  #   likes.count
  #   # has_manyの関係性なのでlikesが取れる
  # end
end
  # private

  # def validate_title_and_content_length
  #   char_count = title.length + content.length
  #   errors.add(:content, '100文字以上で！') unless char_count > 100
  # end
  #   # unless char_count > 100
  #   #     errors.add(:content, '100文字以上で！')
  #   # char = character(文字)
  # end
