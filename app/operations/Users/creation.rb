class Users::Creation < Base::Class
  def call
    ActiveRecord::Base.transaction do
      @user = People::User.new(params)
      @user.role = 'customer'

      unless @user.save
        @user.errors.each { |error| errors.add(error.full_message) }

        return
      end

      @user.send_activation_email
    end
  end
end
