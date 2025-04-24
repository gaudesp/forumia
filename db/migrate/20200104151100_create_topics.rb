class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title, null: false
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :forum, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
