class ApplicationController < ActionController::Base
# 国際化
  before_action :set_locale
  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) if super.present?
    super
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale

    # 設定言語を変更する
  end
end
