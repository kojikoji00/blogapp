class ProfilesController < ApplicationController
  before_action :authenticate_user!
  # ログインしていないとできない
  def show
    @profile = current_user.profile
  end

  def edit
    # if current_user.profile.present?
    #   @profile = current_user.profile
    # else
    #   @profile = current_user.build_profile
    # end
    # has_oneの時は書き方が違う build_モデル名
    # 値がある時は値を渡す。ない時は空のプロフィールをビルドする
    # ↓簡素化させた記載方法
    # @profile = current_user.profile || current_user.build_profile
    @profile = current_user.prepare_profile
    # prepare_profileはuser.rbで定義している
  end

  def update
    @profile = current_user.prepare_profile
    # editと同じ
    # profileparamsの値を入れてられていないため↓追記@profileにprofile_paramsの値を合体
    @profile.assign_attributes(profile_params)
    # @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path, notice: ' プロフィールを更新しました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end
  end

  private
  def profile_params
    params.require(:profile).permit(
      :nickname,
      :introduction,
      :gender,
      :birthday,
      :subscribed,
      :avatar
      # フォームにアバターが追加されたので指定しないと保存する対象にならない
      # avatarを追加
    )
  end
end