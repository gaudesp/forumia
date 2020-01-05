puts "Create roles"
if Role.count == 0
  role = Role.create(label: "Membre", color: "6c757d", icon: "user")
  permission = Permission.new(
    role: role,
    priority_permission: 1
  )
  permission.save(validate: false)
  puts permission
end

role = Role.create(label: "Webmaster", icon: "robot", color: "18BC9C")
permission = Permission.new(
  role: role,
  priority_permission: 100,
  update_permission: true,
  create_article: true,
  update_article: true,
  delete_article: true,
  lock_topic: true,
  unlock_topic: true,
  delete_topic: true,
  pin_topic: true,
  unpin_topic: true,
  delete_message: true,
  kick_user: true,
  unkick_user: true,
  ban_user: true,
  unban_user: true,
  banip_user: true,
  unbanip_user: true,
  delete_user: true,
  create_forum: true,
  update_forum: true,
  delete_forum: true,
  update_role: true,
  delete_role: true,
  update_topic: true,
  update_message: true,
  create_staff: true,
  promote_user: true,
  demote_user: true,
  update_user: true
)
permission.save(validate: false)
puts permission

puts "Create users"

# user = User.create(username: "Nox", password: "a", password_confirmation: "a", email: "gaudespro@gmail.com")
# puts user
user = User.create(username: "Nox", password: "Sr84Ty12%*45", password_confirmation: "Sr84Ty12%*45", email: "gaudespro@gmail.com")
puts user
# user = User.create(username: "Izys", password: "a", password_confirmation: "a", email: "izys@gmail.com")
# puts user
# user = User.create(username: "dadamdr", password: "a", password_confirmation: "a", email: "dadamdr@gmail.com")
# puts user
# user = User.create(username: "super-zen", password: "a", password_confirmation: "a", email: "super-zen@gmail.com")
# puts user
# user = User.create(username: "Drylex", password: "a", password_confirmation: "a", email: "drylex@gmail.com")
# puts user

user = User.first.update(role: role)
puts user