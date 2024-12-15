# frozen_string_literal: true

module Users
  class Updation < Base::Class
    def call
      return self unless valid?

      ActiveRecord::Base.transaction do
        params_to_update = {
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        }

        user.errors.each { |error| errors.add(error.full_message) } unless user.update(params_to_update)
      end

      self
    end

    private

    def validate
      validate_params_presence
      validate_params
      validate_user_presence
      validate_user
    end

    def validate_params_presence
      return if params.present?

      errors.add(I18n.t('api.v1.users.users.errors.blank_params'))
    end

    def validate_params
      validation = Validations::EditUserSchema.new.call(params)

      return if validation.success?

      validation.errors(full: true).to_h.each_value do |value|
        errors.add(value)
      end
    end

    def validate_user_presence
      return if user.present?

      errors.add(I18n.t('api.v1.users.users.errors.invalid_params'))
    end

    def validate_user
      return if user.blank?

      errors.add(I18n.t('api.v1.users.sessions.errors.unactivated_account')) unless user.activated?

      return if user.authenticated?(:reset, params[:id])

      errors.add(I18n.t('api.v1.users.password_resets.errors.invalid_token'))
    end

    def user
      @user ||= User.find_by(email: params[:email]&.downcase)
    end
  end
end
