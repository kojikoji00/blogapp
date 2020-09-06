class Apps::ApplicationController < ApplicationController
  # ログインしていないと見れない部分をappsにまとめる
  before_action :authenticate_user!
end