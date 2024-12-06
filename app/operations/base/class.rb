class Base::Class
  attr_reader :errors, :params

  def initialize(params)
    @params = params

    @errors = Base::Errors.new(self.class.to_s)
  end

  def self.call(params)
    new(params).call
  end

  def success?
    !errors.errors_list.any?
  end
end
