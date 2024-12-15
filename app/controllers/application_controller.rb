class ApplicationController < ActionController::Base
  include LocaleConfigs
  include Redirectable

  around_action :set_locale
  # before_action :check_mfa

  # the default alert and notice
  add_flash_types :success, :danger, :info

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

  # def check_mfa
  #   binding.pry
  #   user_mfa_session = UserMfaSession.find

  #   if !user_mfa_session && (
  #     user_mfa_session ? user_mfa_session.record == current_user : !user_mfa_session
  #   )

  #     redirect_to new_user_mfa_session_path
  #   end

  #   return unless signout_path == request.path

  #   current_user.mfa_secret = nil
  #   current_user.save!

  #   UserMfaSession.destroy
  # end

  # “current_user.google_qr_uri“ and for the key, it is “current_user.google_secret_value“.
end
