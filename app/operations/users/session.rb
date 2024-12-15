# frozen_string_literal: true

module Users
  class Session < Base::Class
    WATING_MINUTES = 15.minutes
    REMEMBER_VALUE = '1'

    attr_reader :session

    def call
      return self unless valid?

      ActiveRecord::Base.transaction do
        @session = user.sessions.build(session_params)

        return self if session.save

        session.errors.each { |error| errors.add(error.full_message) }
      end

      self
    end

    private

    def validate
      validate_params_presence
      validate_params
      validate_user_presence
      validate_user_activation
    end

    def validate_params_presence
      return if params.present?

      errors.add(I18n.t('api.v1.users.users.errors.blank_params'))
    end

    def validate_params
      validation = Validations::SessionSchema.new.call(params)

      nil if validation.success?

      validation.errors(full: true).to_h.each_value do |value|
        errors.add(value)
      end
    end

    def validate_user_presence
      return if user.present?

      errors.add(I18n.t('api.v1.users.sessions.errors.invalid_password_or_email'))
    end

    def validate_user_activation
      return if user.blank?

      unless user.activated?
        errors.add(I18n.t('api.v1.users.sessions.errors.unactivated_account'))

        return
      end

      return if user.authenticate(params[:password])

      errors.add(I18n.t('api.v1.users.sessions.errors.invalid_password_or_email'))
    end

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end

    def session_params
      { uid: SecureRandom.uuid }
    end
  end
end
