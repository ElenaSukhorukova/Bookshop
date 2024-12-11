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
  acts_as_paranoid

  include User::Authorization

  has_secure_password
  has_secure_password :recovery_password, validations: false

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
