# frozen_string_literal: true

module Users
  class Creation < Base::Class
    ABSENT_PARAMS = 'params is blank'

    def call
      return self unless valid?

      ActiveRecord::Base.transaction do
        unless user.save
          user.errors.each { |error| errors.add(error.full_message) }

          return self
        end

        user.send_activation_email
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

      errors.add(ABSENT_PARAMS)
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
