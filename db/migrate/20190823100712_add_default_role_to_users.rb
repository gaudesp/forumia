class AddDefaultRoleToUsers < ActiveRecord::Migration[5.2]
  
  def change
    if Role.count == 0
      role = Role.create(label: "Membre", color: "#6c757d", icon: "user")
      User.find_each do |user|
        user.role = role
        user.save!
      end
    end
  end

end
