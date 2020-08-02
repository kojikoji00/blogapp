class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  # 入力されていないと保存しない
end
