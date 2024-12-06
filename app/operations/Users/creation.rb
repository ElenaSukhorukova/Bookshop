class Users::Creation < Base::Class
  def call
    ActiveRecord::Base.transaction do
      user = People::User.new(params)

      unless user.save
        user.errors.each { |error| errors.add(error.full_message) }

        return self
      end

      user.send_activation_email

      self
    end
  end
end
