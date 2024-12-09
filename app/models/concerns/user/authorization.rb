module User::Authorization
  extend ActiveSupport::Concern

  included do
    #     def remember
    #       remember_token = People::User.new_token

    #       self.remember_token = remember_token
    #       self.update(
    #         remember_digect: People::User.digest(remember_token)
    #       )
    #     end

    #     # TODO rewrite User.first.signed_id expires_in: 15.minutes, purpose: :reset_digest
    #     # User.find_signed signed_id, purpose: :reset_digest
    #     # def create_reset_digest
    #     #   self.generate_token_for(:reset_digest)
    #     #   # .find_by_token_for(:password_reset, token)

    #     #   # self.signed_id expires_in: 2.hours, purpose: :reset_digest
    #     #   # self.reset_token = self.new_token
    #     #   # update(reset_digest: self.digest(reset_token), reset_sent_at: Tome.zone.now)
    #     # end

    #     # TODO or rewrite
    #     #   # Last 10 characters of password salt, which changes when password is updated:
    #     # generates_token_for :password_reset, expires_in: 15.minutes do
    #     #   password_salt&.last(10)
    #     # end

    #     # user = User.first

    #     # token = user.generate_token_for(:password_reset)
    #     # User.find_by_token_for(:password_reset, token) # => user
    #     # # 16 minutes later...
    #     # User.find_by_token_for(:password_reset, token) # => nil

    #     # token = user.generate_token_for(:password_reset)
    #     # User.find_by_token_for(:password_reset, token) # => user
    #     # user.update!(password: "new password")
    #     # User.find_by_token_for(:password_reset, token) # => nil

    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")

      return if digest.blank?

      BCrypt::Password.new(digest).is_password?(token)
    end

    #     def forget
    #       update(remember_digest: nil)
    #     end

    #     def activate
    #       update(activated: true, activated_at: Time.zone.now)
    #     end

    def send_activation_email
      # TODO: Add a worker
      UserMailer.with(user: self).account_activation.deliver_now
    end

    #   #   def send_password_reset_email
    #   #     UserMailer.password_reset(self).deliver_now
    #   #   end

    #   #   # TODO rewrite User.first.signed_id expires_in: 15.minutes, purpose: :reset_digest
    #   #   # User.find_signed signed_id, purpose: :reset_digest
    #   #   def password_reset_expired?
    #   #     reset_sent_at < 2.hours.ago
    #   #   end

    def create_activate_digest
      activeation_token = signed_id(expires_in: 15.minutes, purpose: :activation_token)

      update(
        activation_token: activeation_token,
        activation_digest: User.digest(activeation_token)
      )

      pp '------------------------------'
      pp activation_token
      pp '------------------------------'
    end
  end

  class_methods do
    #     def new_token
    #       SecureRandom.urlsafe_base64
    #     end

    def digest(string)
      cost = BCrypt::Engine::MIN_COST

      BCrypt::Password.create(string, cost: cost)
    end

    #     def from_omniauth(auth)
    #       info = auth.info

    #       user = self.find_or_initialize_by(
    #         uid: auth.uid,
    #         provider: auth.provider,
    #         email: info.email
    #       )

    #       if user.new_record?
    #         password = self.new_token
    #         user.password = password
    #         user.password_confirmation = password
    #         user.provider_settings[:full_name] = info.name
    #         user.provider_settings[:avatar_url] = info.image

    #         user.save

    #         return user
    #       end

    #       if user.provider_settings.blank?
    #         user.update(provider_settings: { full_name: info.name, avatar_url: info.image })
    #       end

    #       user
    #     end
  end
end
