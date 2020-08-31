# frozen_string_literal: true

module UserDecorator
  def display_name
    profile&.nickname || self.email.split('@').first
  end
  # user.rbから移動userクラスのインスタンスとして起動してくれる
  # 画像に関する定義についてはここに書く
  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end
