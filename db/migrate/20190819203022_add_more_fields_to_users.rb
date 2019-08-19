class AddMoreFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :country, :string
    add_column :users, :gender, :integer
  end
end
