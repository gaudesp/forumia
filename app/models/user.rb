class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  belongs_to :role, optional: true

  has_many :topics
  has_many :messages

  enum genders: [ :male, :female, :unknown ]

  validates_presence_of :username, message: "Vous devez choisir un nom d'utilisateur", on: :create
  validates_uniqueness_of :username, case_sensitive: false, message: "Ce nom d'utilisateur n'est pas disponible", on: :create
  validates_length_of :username, in: 3..20, message: "Le nom d'utilisateur doit être compris entre 3 et 20 caractères", on: :create
  validates_format_of :username, with: /\A^[a-zA-Z0-9](\w|\.)*[a-zA-Z0-9]$\Z/i, message: "Ce nom d'utilisateur n'est pas valide", on: :create

  validates_presence_of :email, message: "Vous devez choisir une adresse email"
  validates_uniqueness_of :email, message: "Cette adresse email n'est pas disponible"
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP, message: "Cette adresse email n'est pas valide"
  
  validates_presence_of :password, message: "Vous devez choisir un mot de passe", on: :create
  validates_presence_of :password_confirmation, message: "Vous devez confirmer votre mot de passe", on: :create
  validates_confirmation_of :password, message: "Les deux mots de passes ne correspondent pas"
  
  validates_length_of :description, maximum: 1000, too_long: "Cette description est trop longue", allow_blank: true, on: :update
  
  validates_format_of :music, with: /\A^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$\Z/i, message: "Vous devez renseigner un lien youtube", allow_blank: true, on: :update

  attr_readonly :username, on: :update

  mount_uploader :avatar, AvatarUploader
  mount_uploader :background, BackgroundUploader

  before_create :set_default_role

  def avatar_url
    self.avatar.url(:avatar) || '/uploads/user/avatar/default.png'
  end

  def background_url
    self.background.url(:background) || '/uploads/user/background/default.png'
  end

  def count_messages
    self.messages.count
  end

  def promote(role_id)
    update(role_id: role_id)
  end

  def demote
    update(role_id: 1)
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where("lower(username) = ?", username.downcase).first
    else
      where(conditions).first
    end
  end

  private

  def set_default_role
    self.role = Role.find(1)
  end

end
