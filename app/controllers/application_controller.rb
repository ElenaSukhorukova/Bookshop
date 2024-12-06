class ApplicationController < ActionController::Base
  include LocaleConfigs

  around_action :set_locale

  private

  def set_locale(&action)
    locale   = current_user.try(:locale)
    locale ||= params[:locale]
    locale ||= find_out_locale
    locale ||= I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
