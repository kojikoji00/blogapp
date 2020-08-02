# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # presence 入力されていない場合は保存しない
  def display_created_at
    # I18n.l(@article.created_at, format: :default)
    I18n.l(created_at, format: :default)
    # articleクラスのインスタンスだからそのクラスに定義されているメソッドを使える
    # articleはselfで取得している
  end
end
