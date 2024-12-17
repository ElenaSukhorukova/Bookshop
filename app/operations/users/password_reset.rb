# frozen_string_literal: true

module Users
  class PasswordReset < Base::Class
    def call
      return self unless valid?

      ActiveRecord::Base.transaction do
        user.initiate_reset_password_process
      end

      self
    end

    private

    def validate
      validate_params_presence
      validate_user_presence
      validate_user_activation
    end

    def validate_params_presence
      return if params.present?

      errors.add(I18n.t('api.v1.users.users.errors.blank_params'))
    end

    def validate_user_presence
      return if user.present?

      errors.add(I18n.t('api.v1.users.password_resets.errors.invalid_email'))
    end

    def validate_user_activation
      return if user.blank?
      return if user.activated?

      errors.add(I18n.t('api.v1.users.sessions.errors.unactivated_account'))
    end

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end
  end
end
