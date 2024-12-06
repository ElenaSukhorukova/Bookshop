# frozen_string_literal: true

# t.boolean "activated", default: false
# t.datetime "activated_at"
# t.string "activation_digest"
# t.string "email"
# t.string "password_digest"
# t.string "provider"
# t.jsonb "provider_settings"
# t.string "remember_digest"
# t.string "reset_digest"
# t.datetime "reset_sent_at"
# t.enum "role", default: "customer", enum_type: "user_role"
# t.string "uid"
# t.index ["email"], name: "unique_emails", unique: true

module People
  class User < ApplicationRecord
    has_secure_password
    has_secure_password :recovery_password, validations: false

    #   acts_as_google_authenticated lookup_token: :mfa_secret, encrypt_secrets: true

    validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
    validates :password, presence: true, format: { with: /[\w\d]{1,}|[@.+$!%*#?)(}{&]{1,}|[\w\d]{1,}/ },
                         length: { minimum: 8 }, allow_blank: true,
                         exclusion: {
                           in: ->(user) { [user.email] },
                           message: I18n.t('activerecord.errors.models.user.attributes.password.exclusion')
                         }
    validates :password, confirmation: { unless: -> { password.blank? } }

    # customer employee
    attribute :role, :enum
    enum :role, array_to_enum_hash(EnumLists::USER_ROLES), _prefix: :role, validate: true

    #   store :provider_settings, accessors: %i[full_name avatar_url], coder: JSON

    #   attr_accessor :remember_token, :activation_token, :reset_token

    normalizes :email, with: ->(email) { email.strip.downcase }

    before_save :make_normalize
    after_create :create_activate_digest

    #   has_one :profile, class_name: 'People::Profile', dependent: :destroy

    #   scope :active_employees, -> { where(role: 'employee') }
    #   scope :active_customers, -> { where(role: 'customer') }

    private

    def make_normalize
      normalize_attribute(:email)
    end
  end
end
