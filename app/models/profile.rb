# t.uuid "profilable_id"
# t.string "profilable_type"
# t.index ["profilable_type", "profilable_id"], name: "index_profiles_on_profilable"

class Profile < ApplicationRecord
  delegated_type :profilable, types: %w[People::Employee People::Customer], dependent: :destroy

  validates_comparison_of :birth_day, greater_than: 1900, less_than: -> { Date.today - 18.years }
  validates :first_name, :last_name, length: { maximum: 30 }

  belongs_to :user
  # has_many :addresses, as: :addressable,
  #         class_name: 'Internal::Address', dependent: :destroy
  # has_one :pictures, as: :imageable,
  #         class_name: 'Internal::Picture', dependent: :destroy

  # accepts_nested_attributes_for :addresses, allow_destroy: true, allow_blank: true

  # Entry.create! entryable: Message.new(subject: "hello!")
  # def self.create_with_employee(params, user: user)
  #   create! profilable: Employee.new(params), user: user
  # end

  # def self.create_with_customer(params, user: user)
  #   create! profilable: Customer.new(params), user: user
  # end

  # def employee?
  #   self.profilable_type == 'Employee'
  # end
end
