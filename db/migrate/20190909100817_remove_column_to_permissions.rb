class RemoveColumnToPermissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :permissions, :create_topic, :boolean, default: false
    remove_column :permissions, :create_message, :boolean, default: false
  end
end
