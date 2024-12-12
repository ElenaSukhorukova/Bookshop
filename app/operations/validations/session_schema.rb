module Validations
  class SessionSchema < Dry::Validation::Contract
    schema do
      required(:email).filled(:str?)
      required(:password).filled(:str?)
      optional(:remember_me).filled(:str?)
    end
  end
end
