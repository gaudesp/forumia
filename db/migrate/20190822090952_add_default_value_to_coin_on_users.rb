class AddDefaultValueToCoinOnUsers < ActiveRecord::Migration[5.2]

  def up
    change_column :users, :coin, :decimal, precision: 8, scale: 2, default: 0
    User.find_each do |user|
      user.coin = 0
      user.save!
    end
  end

  def down
    change_column :users, :coin, :decimal, precision: 8, scale: 2
  end

end
