class Forum < ApplicationRecord

  belongs_to :category
  belongs_to :role

  has_many :topics
  
  validates_presence_of :name, message: "Vous devez renseigner un nom"
  validates_uniqueness_of :name, message: "Ce nom est déjà utilisé"

  validates_presence_of :description, message: "Vous devez renseigner une description"

  validates_presence_of :category_id, message: "Vous devez choisir une catégorie"

  validates_presence_of :role_id, message: "Vous devez choisir un rôle"

  after_validation :set_slug

  def to_param
    "#{id}-#{slug}"
  end

  def count_topics
    self.topics.count
  end

  def count_messages
    self.topics.joins(:messages).where('messages.topic_id = topics.id').count
  end

  private

  def set_slug
    self.slug = name.to_s.parameterize
  end

end
