# frozen_string_literal: true

module Base
  class Errors
    attr_accessor :errors_list, :class_name

    def initialize(class_name)
      @class_name = class_name
      @errors_list = []
    end

    def add(error)
      errors_list.push(error)

      Rails.logger.debug("#{class_name} >> #{error}")
    end

    def full_message
      errors_list.join('; ')
    end
  end
end
