class Role < ApplicationRecord

  has_many :users
  has_many :forums
  has_one :permission, inverse_of: :role, autosave: true

  accepts_nested_attributes_for :permission, allow_destroy: true

  validates_presence_of :label, message: "Vous devez renseigner un nom"
  validates_uniqueness_of :label, message: "Ce nom est déjà utilisé"

  validates_presence_of :color, message: "Vous devez choisir une couleur"
  validates_uniqueness_of :color, message: "Cette couleur est déjà utilisé"

  validates_presence_of :icon, message: "Vous devez renseigner une icône"
  validates_uniqueness_of :icon, message: "Cette icône est déjà utilisé"

  before_save :set_color
  after_validation :set_slug

  def to_param
    "#{id}-#{slug}"
  end

  private

  def set_color
    self.color = color.insert(0, '#')
  end

  def set_slug
    self.slug = label.to_s.parameterize
  end

end
