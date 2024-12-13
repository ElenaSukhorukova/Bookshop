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
# t.index ["email"], name: "unique_emails", unique: true

class User < ApplicationRecord
  include User::Authorization

  attribute :remember_token, :string

  generates_token_for :remember_token, expires_in: 14.days
  generates_token_for :activation_token, expires_in: 15.minutes

  has_secure_password
  has_secure_password :recovery_password, validations: false

  has_one :profile, dependent: :destroy
  has_many :sessions, dependent: :destroy

  # customer employee admin
  attribute :role, :enum
  enum :role, array_to_enum_hash(EnumLists::USER_ROLES), _prefix: :role, validate: true

  normalizes :email, with: ->(email) { email.strip.downcase }

  before_save :make_normalize
  after_create :create_activate_digest

  private

  def make_normalize
    normalize_attribute(:email)
  end
end
