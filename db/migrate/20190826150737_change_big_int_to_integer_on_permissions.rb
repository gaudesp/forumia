class ChangeBigIntToIntegerOnPermissions < ActiveRecord::Migration[5.2]
  def up
    change_column :permissions, :role_id, :integer
  end
  def down
    change_column :permissions, :role_id, :bigint
  end
end
