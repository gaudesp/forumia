class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string
    add_column :users, :birthdate, :date
    add_column :users, :description, :text
    add_column :users, :avatar, :string
    add_column :users, :music, :string
    add_column :users, :background, :string
    add_column :users, :coin, :decimal, index: true, precision: 8, scale: 2
    add_reference :users, :role, index: true
    add_foreign_key :users, :roles, on_delete: :cascade
  end
end
