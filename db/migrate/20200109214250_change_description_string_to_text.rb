class ChangeDescriptionStringToText < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :description, :text
    change_column :forums, :description, :text
    change_column :messages, :content, :text
  end
end
