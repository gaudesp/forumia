class Role < ApplicationRecord
  has_many :users
  has_one :permission, inverse_of: :role

  accepts_nested_attributes_for :permission, allow_destroy: true

end