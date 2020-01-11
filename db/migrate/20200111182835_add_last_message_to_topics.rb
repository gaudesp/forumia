class AddLastMessageToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :last_message, :datetime, null: false
  end
end
