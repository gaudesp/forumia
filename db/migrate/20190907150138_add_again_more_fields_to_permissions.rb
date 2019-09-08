class AddAgainMoreFieldsToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :create_topic, :boolean, default: false
    add_column :permissions, :update_topic, :boolean, default: false
    add_column :permissions, :create_message, :boolean, default: false
    add_column :permissions, :update_message, :boolean, default: false
    add_column :permissions, :update_user, :boolean, default: false
  end
end
