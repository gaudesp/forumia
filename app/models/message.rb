class Message < ApplicationRecord

  belongs_to :topic
  belongs_to :user

  validates_presence_of :content, message: "Vous devez renseigner le message du sujet"
  validates_presence_of :topic

  after_validation :set_last_message
  before_validation :set_user

  private

  def set_last_message
    self.topic.update(last_message: Time.now)
  end

  def set_user
    self.user = User.current
  end

end
