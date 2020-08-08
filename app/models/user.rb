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
  has_one :profile, dependent: :destroy
  # userと記事を紐付ける 複数の記事と紐づけるので複数形
  # user削除された時に記事も一緒に削除される

  delegate :birthday, :age, :gender, to: :profile, allow_nil: true
  # profileモデルからメソッドを持ってきます
  # 下のぼっち演算子不要になる

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def display_name
    profile&.nickname || self.email.split('@').first
    # ぼっち演算子 ：&. nilじゃ無い時だけnicknameを実行
    # if  profile && profile.nickname
    #   profile.nickname
    # else
    #   self.email.split('@').first
    # end
    # profile.nickname || self.email.split('@').first
    # self.email.split('@').first
    # @で分割する emailの@以前を取得
    # profileのニックネームもしくはEmailの最初を指定
  end
  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end
