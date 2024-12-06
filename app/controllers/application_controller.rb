class ApplicationController < ActionController::Base
  include LocaleConfigs

  # around_action :set_locale

  private

  def set_locale(&action)
    # locale = current_user.try(:locale) if current_user.present?
    # locale = params[:locale] ||
    #          find_out_locale ||
    #          I18n.default_locale

    # I18n.with_locale(locale, &action)
  end
end
