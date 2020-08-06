# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :content, uniqueness: true
  validate :validate_title_and_content_length
  belongs_to :user
  # validateは独自ルール
  # presence 入力されていない場合は保存しない
  # 一人のユーザーにしか紐づかないので単数形userで書く
  def display_created_at
    I18n.l(created_at, format: :default)
  end
    # I18n.l(@article.created_at, format: :default)
    # articleクラスのインスタンスだからそのクラスに定義されているメソッドを使える
    # articleはselfで取得している

  def author_name
    user.display_name
  end

  private

  def validate_title_and_content_length
    char_count = title.length + content.length
    errors.add(:content, '100文字以上で！') unless char_count > 100
  end
    # unless char_count > 100
    #     errors.add(:content, '100文字以上で！')
    # char = character(文字)
  end
