module Validations
  class UserSchema < Dry::Validation::Contract
    schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?, min_size?: 8)
      required(:password_confirmation).filled(:str?)
    end

    rule(:email) do
      unless /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/.match?(value)
        key.failure(I18n.t('dry_validation.errors.user.format'))
      end
    end

    rule(:password) do
      unless /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.match?(value)
        key.failure(I18n.t('dry_validation.errors.user.format'))
      end
    end

    rule(:password, :email) do
      key.failure(I18n.t('dry_validation.errors.user.password_exclusion')) if values[:password] == values[:email]
    end

    rule(:password, :password_confirmation) do
      if values[:password].present? && (values[:password] != values[:password_confirmation])
        key.failure(I18n.t('dry_validation.errors.user.password_similarity'))
      end
    end
  end
end
