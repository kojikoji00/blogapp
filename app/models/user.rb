# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
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
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  # フォローしている人たちのことをfollowingという
  # 自分がフォロワーになっているときのフォローしている時のデータを持ってくる following_relationships
  # user has_many_likesだと察してくれるけど今回は違うから指定しなければならない
  #  本来であればuserとarticleは紐づいていない has_manyの関係
  #  through:likesテーブルを通して記事をとる
  #  davoriteメソッドは本来存在しないのでarticleのことを言っていると説明
  has_one :profile, dependent: :destroy
  # userと記事を紐付ける 複数の記事と紐づけるので複数形
  # user削除された時に記事も一緒に削除される

  delegate :birthday, :age, :gender, to: :profile, allow_nil: true
  # profileモデルからメソッドを持ってきます
  # 下のぼっち演算子不要になる

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
    # 要確認 article_idがarticle.idだった時
  end
  # いいねしているかどうかの確認

  def follow!(user)
    # if user.is_a?(User)
    #   user_id = user.id
    # else
    #   user_id = user
    #   # is_a?:インスタンスだった場合
    # end
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end
  # following_relationships.create!(following_id: user.id)
  # follower.idは自分が紐付けられるのであとはfollowingのユーザー情報が必要

  def unfollow!(user)
    # if user.is_a?(User)
    #   user_id = user.id
    # else
    #   user_id = user
    #   # is_a?:インスタンスだった場合
    # end
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
    # followしている対象が存在しないとおかしいから「！」をつける
  end
  # current_user.has_followed(User.second)
  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  # def display_name
  #   profile&.nickname || self.email.split('@').first
  # end
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
  # def birthday
  #   profile&.birthday
  # end

  # def gender
  #   profile&.gender
  # end

  def prepare_profile
    profile || build_profile
  end

  # def avatar_image
  #   if profile&.avatar&.attached?
  #     profile.avatar
  #   else
  #     'default-avatar.png'
  #   end
  # end

  private
  def get_user_id(user)
    # if user.is_a?(User)
    #   user_id = user.id
    # else
    #   user_id = user
    #   # is_a?:インスタンスだった場合
    # end
    if user.is_a?(User)
      user.id
    else
      user
    end
      # is_a?:インスタンスだった場合
      # user_idに代入する必要がなくなる
      # followとunfollowのなかでしか使わないからprivateのなかにいれる
     # private内ではuserインスタンスから呼び出せない
  end
end
