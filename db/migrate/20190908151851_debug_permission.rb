class DebugPermission < ActiveRecord::Migration[5.2]
  def change
    remove_column :permissions, :create_role, :boolean, default: false
    add_column :permissions, :create_staff, :boolean, default: false
    # create_role a l'air déjà réservé par Rails, on remplace par create_staff
  end
end
