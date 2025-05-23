class Topic < ApplicationRecord

  belongs_to :forum
  belongs_to :user

  has_many :messages, inverse_of: :topic

  accepts_nested_attributes_for :messages, allow_destroy: true

  enum :status, { normal: 0, locked: 1, pinned: 2, pinlocked: 3 }

  validates_presence_of :title, message: "Vous devez renseigner le titre du sujet"
  validates_length_of :title, message: "Le titre doit être compris entre 1 et 60 caractères", minimum: 1, maximum: 60, allow_blank: false

  after_validation :set_slug
  after_validation :set_last_message
  before_validation :set_user, on: :create

  def to_param
    "#{id}-#{slug}"
  end

  def count_messages
    self.messages.count
  end

  private

  def set_slug
    self.slug = title.to_s.parameterize
  end

  def set_last_message
    self.last_message = Time.now
  end

  def set_user
    self.user = User.current
  end

end
