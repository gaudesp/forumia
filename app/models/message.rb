class Message < ApplicationRecord

  belongs_to :topic
  belongs_to :user

  validates_presence_of :content, message: "Vous devez renseigner le message du sujet"
  validates_presence_of :topic

  before_validation :set_user

  private

  def set_user
    self.user = User.current
  end

end
