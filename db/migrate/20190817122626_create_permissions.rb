class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.boolean :create_article, default: false
      t.boolean :update_article, default: false
      t.boolean :delete_article, default: false
      t.boolean :undelete_article, default: false
      t.boolean :kill_article, default: false
      t.boolean :lock_topic, default: false
      t.boolean :unlock_topic, default: false
      t.boolean :delete_topic, default: false
      t.boolean :undelete_topic, default: false
      t.boolean :kill_topic, default: false
      t.boolean :pin_topic, default: false
      t.boolean :unpin_topic, default: false
      t.boolean :delete_message, default: false
      t.boolean :undelete_message, default: false
      t.boolean :kill_message, default: false
      t.boolean :kick_user, default: false
      t.boolean :unkick_user, default: false
      t.boolean :ban_user, default: false
      t.boolean :unban_user, default: false
      t.boolean :banip_user, default: false
      t.boolean :unbanip_user, default: false
      t.boolean :kill_user, default: false

      t.timestamps
    end
  end
end
