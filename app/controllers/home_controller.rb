class HomeController < ApplicationController
  def index
    # render 'home/index'
    @article = Article.first
    # Articleモデルをインスタンス変数に
  end
  def about
  end
end