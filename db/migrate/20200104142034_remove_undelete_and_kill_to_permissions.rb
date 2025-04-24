class RemoveUndeleteAndKillToPermissions < ActiveRecord::Migration[5.2]
  def change
    remove_column :permissions, :undelete_article, :boolean, default: false
    remove_column :permissions, :kill_article, :boolean, default: false
    remove_column :permissions, :undelete_topic, :boolean, default: false
    remove_column :permissions, :kill_topic, :boolean, default: false
    remove_column :permissions, :undelete_message, :boolean, default: false
    remove_column :permissions, :kill_message, :boolean, default: false
    remove_column :permissions, :kill_user, :boolean, default: false
    remove_column :permissions, :undelete_forum, :boolean, default: false
    remove_column :permissions, :kill_forum, :boolean, default: false
    remove_column :permissions, :undelete_role, :boolean, default: false
    remove_column :permissions, :kill_role, :boolean, default: false

    add_column :permissions, :delete_user, :boolean, default: false
    
  end
end
