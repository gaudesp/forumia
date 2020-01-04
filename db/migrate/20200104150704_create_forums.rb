class CreateForums < ActiveRecord::Migration[5.2]
  def change
    create_table :forums do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.references :category, foreign_key: { on_delete: :cascade }
      t.references :role, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
