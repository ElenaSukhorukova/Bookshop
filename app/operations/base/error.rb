class Base::Errors
  attr_accessor :errors, :class_name

  def initialize(class_name)
    @class_name = class_name
    @errors = []
  end

  def add(error)
    errors.push(error)

    Rails.logger.debug("#{class_name} >> #{error}")
  end
end
