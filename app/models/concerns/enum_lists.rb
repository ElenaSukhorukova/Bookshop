module EnumLists
  extend ActiveSupport::Concern

  included do
    USER_ROLES = %w(
      customer employee admin
    ).freeze
  end
end
