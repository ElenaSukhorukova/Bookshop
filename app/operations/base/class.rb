class Base::Class
  attr_reader :errors, :params

  def initialize(params)
    @params = params
    @errors = Base::Errors.new(chid_class.name)
  end

  def self.call(params)
    new(params).call
  end

  def success?
    errors.any?
  end
end
