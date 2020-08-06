# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
              :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  # userと記事を紐付ける 複数の記事と紐づけるので複数形
  # user削除された時に記事も一緒に削除される

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def display_name
    self.email.split('@').first
    # @で分割する emailの@以前を取得
  end
end
