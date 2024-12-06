# frozen_string_literal: true

module Users
  class Creation < Base::Class
    ABSENT_USER = 'params.user is blank'

    def call
      user = params[:user]

      return self unless valid?

      ActiveRecord::Base.transaction do
        unless user.save
          user.errors.each { |error| errors.add(error.full_message) }

          return self
        end

        user.send_activation_email

        self
      end
    end

    private

    def validate
      return if params[:user].present?

      errors.add(ABSENT_USER)
    end
  end
end
