class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  
  validates_presence_of :username, message: "Vous devez choisir un nom d'utilisateur"
  validates_uniqueness_of :username, case_sensitive: false, message: "Ce nom d'utilisateur n'est pas disponible"
  validates_length_of :username, in: 3..16, message: "Le nom d'utilisateur doit être compris entre 3 et 16 caractères"
  validates_format_of :username, with: /\A^[a-zA-Z0-9](\w|\.)*[a-zA-Z0-9]$\Z/i, message: "Ce nom d'utilisateur n'est pas valide"

  validates_presence_of :email, message: "Vous devez choisir une adresse email"
  validates_uniqueness_of :email, message: "Cette adresse email n'est pas disponible"
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, message: "Cette adresse email n'est pas valide"
  
  validates_presence_of :password, message: "Vous devez choisir un mot de passe"
  validates_length_of :password, minimum: 6, message: "Le mot de passe doit contenir 6 caractères minimum"
  validates_confirmation_of :password, message: "Les deux mots de passes ne correspondent pas"

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where("lower(username) = ?", username.downcase).first
    else
      where(conditions).first
    end
  end

end
