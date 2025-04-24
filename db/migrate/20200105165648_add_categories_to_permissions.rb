class AddCategoriesToPermissions < ActiveRecord::Migration[5.2]
  def change
    add_column :permissions, :create_category, :boolean, default: false
    add_column :permissions, :update_category, :boolean, default: false
    add_column :permissions, :delete_category, :boolean, default: false
  end
end
