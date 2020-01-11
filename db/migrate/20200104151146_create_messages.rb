class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content, null: false
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :topic, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
