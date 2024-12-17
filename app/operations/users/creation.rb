# frozen_string_literal: true

module Users
  class Creation < Base::Class
    WATING_MINUTES = 15.minutes
    WAITING_SECONDS = 2.seconds

    attr_reader :user

    def call # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      return self unless valid?

      @user = User.new(params)

      ActiveRecord::Base.transaction do
        unless user.save
          user.errors.each { |error| errors.add(error.full_message) }

          return self
        end

        user.initiate_activate_process

        DeletionUnactivatedUserWorker.perform_in(WATING_MINUTES, user.id)
      end

      self
    end

    private

    def validate
      validate_params_presence
      validate_params
    end

    def validate_params_presence
      return if params.present?

      errors.add(I18n.t('api.v1.users.users.errors.blank_params'))
    end

    def validate_params
      validation = Validations::UserSchema.new.call(params)

      return if validation.success?

      validation.errors(full: true).to_h.each_value do |value|
        errors.add(value)
      end
    end
  end
end
