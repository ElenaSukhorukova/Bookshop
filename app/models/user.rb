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

class User < ApplicationRecord
  include User::Authorization

  attr_accessor :activation_token # , :remember_token, :reset_token

  has_secure_password
  has_secure_password :recovery_password, validations: false

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, format: { with: /[\w\d]{1,}|[@.+$!%*#?)(}{&]{1,}|[\w\d]{1,}/ },
                       length: { minimum: 8 }, allow_blank: true,
                       exclusion: {
                         in: ->(user) { [user.email] },
                         message: I18n.t('activerecord.errors.models.user.attributes.password.exclusion')
                       }
  validates :password, confirmation: { unless: -> { password.blank? } }

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), _prefix: :role, validate: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  before_save :make_normalize
  after_create :create_activate_digest

  # find unactivated user or create new
  def self.find_or_new(params)
    user = find_by(email: params[:email], activated: false)

    return new(params) if user.blank?

    user
  end

  private

  def make_normalize
    normalize_attribute(:email)
  end
end
