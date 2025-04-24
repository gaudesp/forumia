class AddMoreFieldsToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :create_forum, :boolean, default: false
    add_column :permissions, :update_forum, :boolean, default: false
    add_column :permissions, :delete_forum, :boolean, default: false
    add_column :permissions, :undelete_forum, :boolean, default: false
    add_column :permissions, :kill_forum, :boolean, default: false
    add_column :permissions, :create_role, :boolean, default: false
    add_column :permissions, :update_role, :boolean, default: false
    add_column :permissions, :delete_role, :boolean, default: false
    add_column :permissions, :undelete_role, :boolean, default: false
    add_column :permissions, :kill_role, :boolean, default: false
    add_column :permissions, :update_permission, :boolean, default: false
    add_column :permissions, :priority_permission, :integer, default: nil
  end
end
