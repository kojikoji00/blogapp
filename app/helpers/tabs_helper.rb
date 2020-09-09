module TabsHelper
  # viewで使えるメソッドhelperでも使える（current_page?）
  def add_active_class(path)
    path = path.split('?').first
    'active' if current_page?(path)
  end
end