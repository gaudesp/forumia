puts "Create roles"
if Role.count == 0
  role = Role.create(label: "Membre", color: "#6c757d", icon: "user")
  permission = Permission.new(
    role: role,
    priority_permission: 1,
    update_permission: false,
    create_article: false,
    update_article: false,
    delete_article: false,
    undelete_article: false,
    kill_article: false,
    lock_topic: false,
    unlock_topic: false,
    delete_topic: false,
    undelete_topic: false,
    kill_topic: false,
    pin_topic: false,
    unpin_topic: false,
    delete_message: false,
    undelete_message: false,
    kill_message: false,
    kick_user: false,
    unkick_user: false,
    ban_user: false,
    unban_user: false,
    banip_user: false,
    unbanip_user: false,
    kill_user: false,
    create_forum: false,
    update_forum: false,
    delete_forum: false,
    undelete_forum: false,
    kill_forum: false,
    update_role: false,
    delete_role: false,
    undelete_role: false,
    kill_role: false,
    update_topic: false,
    update_message: false,
    create_staff: false,
    promote_user: false,
    demote_user: false
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
  undelete_article: true,
  kill_article: true,
  lock_topic: true,
  unlock_topic: true,
  delete_topic: true,
  undelete_topic: true,
  kill_topic: true,
  pin_topic: true,
  unpin_topic: true,
  delete_message: true,
  undelete_message: true,
  kill_message: true,
  kick_user: true,
  unkick_user: true,
  ban_user: true,
  unban_user: true,
  banip_user: true,
  unbanip_user: true,
  kill_user: true,
  create_forum: true,
  update_forum: true,
  delete_forum: true,
  undelete_forum: true,
  kill_forum: true,
  update_role: true,
  delete_role: true,
  undelete_role: true,
  kill_role: true,
  update_topic: true,
  update_message: true,
  create_staff: true,
  promote_user: true,
  demote_user: true
)
permission.save(validate: false)
puts permission

puts "Create users"

user = User.create(username: "Nox", password: "a", password_confirmation: "a", email: "nox@gmail.com")
puts user
user = User.create(username: "Izys", password: "a", password_confirmation: "a", email: "izys@gmail.com")
puts user
user = User.create(username: "dadamdr", password: "a", password_confirmation: "a", email: "dadamdr@gmail.com")
puts user
user = User.create(username: "super-zen", password: "a", password_confirmation: "a", email: "super-zen@gmail.com")
puts user
user = User.create(username: "Drylex", password: "a", password_confirmation: "a", email: "drylex@gmail.com")
puts user

user = User.first.update(role: role)
puts user