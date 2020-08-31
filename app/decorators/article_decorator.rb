module ArticleDecorator
  def display_created_at
    I18n.l(created_at, format: :default)
  end
    # I18n.l(@article.created_at, format: :default)
    # articleクラスのインスタンスだからそのクラスに定義されているメソッドを使える
    # articleはselfで取得している

  def author_name
    user.display_name
  end

  def like_count
    likes.count
    # has_manyの関係性なのでlikesが取れる
  end
end