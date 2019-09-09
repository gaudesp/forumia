class AddPromoteAndDemoteToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :promote_user, :boolean, default: false
    add_column :permissions, :demote_user, :boolean, default: false
  end
end