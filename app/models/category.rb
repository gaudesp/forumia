class Category < ApplicationRecord

  has_many :forums

  validates_presence_of :name, message: "Vous devez renseigner un nom"
  validates_uniqueness_of :name, message: "Ce nom est déjà utilisé"

  validates_presence_of :description, message: "Vous devez renseigner une description"
  
  validates_presence_of :icon, message: "Vous devez renseigner une icône"
  validates_uniqueness_of :icon, message: "Cette icône est déjà utilisé"

  after_validation :set_slug

  def to_param
    "#{id}-#{slug}"
  end

  def count_forums
    self.forums.count
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end

end
