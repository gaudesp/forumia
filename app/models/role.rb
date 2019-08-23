class Role < ApplicationRecord
  has_many :users
  belongs_to :permission, optional: true

  before_create :link_permission

  def link_permission
    self.permission = Permission.create
  end

end