# frozen_string_literal: true

class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def account_activation
    @user = params[:user]

    mail to: @user.email, subject: t('.subject')
  end

  def password_reset
    @user = params[:user]

    mail to: @user.email, subject: t('.subject')
  end
end
