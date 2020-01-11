class AddStatusToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :status, :integer, default: 0
  end
end
