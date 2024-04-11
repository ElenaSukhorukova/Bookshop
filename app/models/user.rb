class User < ApplicationRecord
  has_secure_password
  has_secure_password :recovery_password, validations: false

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, format: { with: /[\w\d]{1,}|[@.+$!%*#?)(}{&]{1,}|[\w\d]{1,}/ },
                      length: { minimum: 8 }, allow_blank: true,
                      exclusion: { in: ->(user) { [user.email] }, message: 'should not be the same as your email' }
  validates_confirmation_of :password, unless: -> { password.blank? }

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), _prefix: :role, validate: true

  store :provider_settings, accessors: %i[full_name avatar_url], coder: JSON

  # attr_accessor :remember_token, :activation_token, :reset_token

  # after_create :create_activate_digest
end
