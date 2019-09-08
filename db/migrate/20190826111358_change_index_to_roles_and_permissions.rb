class ChangeIndexToRolesAndPermissions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :roles, :permission, index: true, foreign_key: { on_delete: :cascade }
    add_reference :permissions, :role, index: true, foreign_key: { on_delete: :cascade }
  end
end
