class DebugPermission < ActiveRecord::Migration[5.2]
  def change
    remove_column :permissions, :create_role, :boolean, default: false
    add_column :permissions, :create_staff, :boolean, default: false
  end
end
