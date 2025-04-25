# Forumia 🎙️📝
**Forumia** est une application web type forum de discussion (orienté [*JVC-Like*](https://jvflux.fr/JV-like)) développée en **Ruby** avec **Rails**, permettant aux utilisateurs de créer et participer à des discussions en ligne.

## ⚙️ Prérequis
- **Ruby** (*version* : `3.4.3`)
- **Rails** (*version* : `8.0.2`)
- **PostgreSQL** (*version* : `12.22`)
- **Bundler** (*version* : `2.6.8`)
- Un **terminal** compatible **Bash** (*sur WSL ou Unix-like*)

> 💡 Forumia utilise `importmap-rails` pour gérer les dépendances JavaScript, vous n'avez donc pas besoin de Node.js ou Yarn.

## 🚀 Setup

1. **Clonez le repository**  
```bash
git clone git@github.com:gaudesp/forumia.git
cd forumia
```

2. **Installez les gems**  
```bash
bundle install
```

3. **Préparez la base de données**  
Ouvrez `config/database.yml` et ajustez `username`, `password` et `host` selon votre environnement.

Créez, migrez et chargez les données de seed en une seule commande :
```bash
bundle exec rails db:setup
```

4. **Lancez l'application en développement**  
```bash
bundle exec rails server
```

5. **Accédez à l'application localement**  
- APP accessible via : [http://localhost:3000](http://localhost:3000)

## 📦 Dépendances
- `rails` : Framework web MVC.
- `pg` : Adaptateur PostgreSQL.
- `puma` : Serveur web.
- `importmap-rails` : Gestion des modules JavaScript sans bundler.
- `turbo-rails` : Accélération des interactions en Hotwire.
- `stimulus-rails` : Framework JS léger pour composants.
- `sass-rails` : Préprocesseur SCSS.
- `jbuilder` : Construction de JSON pour API.
- `devise` : Authentification et gestion des utilisateurs.
- `carrierwave` & `cloudinary` : Uploads et stockage de fichiers.
- `will_paginate` : Pagination des listes.
- `rspec-rails`, `capybara`, `selenium-webdriver` : Tests et intégration continue.

## 🤝 Contribution
Lead developer : [@gaudesp](https://github.com/gaudesp)
