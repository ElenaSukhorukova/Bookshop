# frozen_string_literal: true

module Base
  class Class
    attr_reader :errors, :params

    def initialize(params)
      @params = params[:params]

      @errors = Errors.new(self.class.to_s)
    end

    def self.call(params)
      new(params).call
    end

    def success?
      errors.errors_list.none?
    end

    private

    def valid?
      validate

      success?
    end
  end
end
