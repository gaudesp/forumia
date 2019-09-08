if Role.count == 0
  role = Role.create(label: "Membre", color: "#6c757d", icon: "user")
  permission = Permission.create(role: role, priority_permission: 1)
end

role = Role.create(label: "Webmaster", icon: "robot", color: "#18BC9C")
permission = Permission.create(role: role, priority_permission: 100, update_permission: true)

User.create(username: "Nox", password: "a", password_confirmation: "a", email: "gaudespro@gmail.com", role: role)