class Permission < ApplicationRecord
  belongs_to :role, optional: true
  
  validates_presence_of :priority_permission, message: "Vous devez renseigner la priorité"
  validates_uniqueness_of :priority_permission, message: "Cette priorité est déjà utilisé"

  validate :check_priority_permission

  def check_priority_permission
    if User.current
      return errors.add(:priority_permission, "Vous devez choisir une priorité inférieur à #{User.current.role.permission.priority_permission}") if priority_permission.to_i > User.current.role.permission.priority_permission
    end
  end
  
end