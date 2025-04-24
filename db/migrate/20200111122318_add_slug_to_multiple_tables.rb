class AddSlugToMultipleTables < ActiveRecord::Migration[5.2]
  def change
    add_column :forums, :slug, :string, null: false
    add_column :topics, :slug, :string, null: false
    add_column :categories, :slug, :string, null: false
    add_column :roles, :slug, :string, null: false
  end
end
