class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :label
      t.string :color
      t.string :icon
      t.references :permission, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
