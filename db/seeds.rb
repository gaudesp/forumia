puts "Créations des roles :"
if !Role.find_by_label("Membre")
  role = Role.create(label: "Membre", color: "6c757d", icon: "user")
  permission = Permission.new(
    role: role,
    priority_permission: 1
  )
  permission.save(validate: false)
  puts "- Role Membre créé avec succès"
else
  puts "- Role Membre déjà présent"
end

if !Role.find_by_label("Webmaster")
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
    update_user: true,
    create_category: true,
    update_category: true,
    delete_category: true
  )
  permission.save(validate: false)
  puts "- Role Webmaster créé avec succès"
else
  puts "- Role Webmaster déjà présent"
end

puts ""

puts "Créations des utilisateurs :"

if !User.find_by_username("Nox")
  user = User.create(username: "Nox", password: "password", password_confirmation: "password", email: "gaudespro@gmail.com")
  puts "- Utilisateur Nox créé avec succès"
  user = User.first.update(role: role)
  puts "- Role Webmaster ajouté à l'utilisateur Nox"
else
  puts "- Utilisateur Nox déjà présent"
end

puts ""

puts "Créations des catégories :"

if !Category.find_by_name("Communauté")
  category = Category.new(name: "Communauté", description: "Regroupe les forums destinés à la communauté", icon: "university")
  if category.save
    puts "- Catégorie #{category.name} créée avec succès"
  else
    puts "- Category #{category.name} Erreur : #{forum.errors.full_messages}"
  end
else
  puts "- Catégorie Communauté déjà présente"
end

if !Category.find_by_name("Administration")
  category = Category.new(name: "Administration", description: "Regroupe les forums destinés à l'administration", icon: "tools")
  if category.save
    puts "- Catégorie #{category.name} créée avec succès"
  else
    puts "- Category #{category.name} Erreur : #{forum.errors.full_messages}"
  end
else
  puts "- Catégorie Administration déjà présente"
end

puts ""

puts "Créations des forums :"

if !Forum.find_by_name("Blabla Général")
  forum = Forum.new(name: "Blabla Général", description: "Forum pour discuter de tout et de rien", role: Role.first, category: Category.find(1))
  if forum.save
    puts "- Forum #{forum.name} créé avec succès"
  else
    puts "- Erreur : #{forum.errors.full_messages}"
  end
else
  puts "- Forum Blabla Général déjà présent"
end

if !Forum.find_by_name("Suggestion & Réclamation")
  forum = Forum.new(name: "Suggestion & Réclamation", description: "Forum pour suggérer une idée ou faire une réclamation", role: Role.first, category: Category.find(2))
  if forum.save
    puts "- Forum #{forum.name} créé avec succès"
  else
    puts "- Erreur : #{forum.errors.full_messages}"
  end
else
  puts "- Forum Suggestion & Réclamation déjà présent"
end

# if !Forum.find_by_name("Webmaster Forum")
#   forum = Forum.new(name: "Webmaster Forum", description: "Forum réservé au grade Webmaster", role: Role.find(2), category: Category.find(1))
#   if forum.save
#     puts "- Forum #{forum.name} créé avec succès"
#   else
#     puts "- Erreur : #{forum.errors.full_messages}"
#   end
# else
#   puts "- Forum Webmaster Forum déjà présent"
# end

puts ""

# user = User.create(username: "Nox", password: "a", password_confirmation: "a", email: "gaudespro@gmail.com")
# puts user
# user = User.create(username: "Izys", password: "a", password_confirmation: "a", email: "izys@gmail.com")
# puts user
# user = User.create(username: "dadamdr", password: "a", password_confirmation: "a", email: "dadamdr@gmail.com")
# puts user
# user = User.create(username: "super-zen", password: "a", password_confirmation: "a", email: "super-zen@gmail.com")
# puts user
# user = User.create(username: "Drylex", password: "a", password_confirmation: "a", email: "drylex@gmail.com")
# puts user
