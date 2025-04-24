class Message < ApplicationRecord

  belongs_to :topic
  belongs_to :user

  validates_presence_of :content, message: "Vous devez renseigner le message du sujet"
  validates_presence_of :topic

  after_validation :set_last_message
  after_create :create_notifications
  before_validation :set_user

  def page(order = :id, per_page = 20)
    position = Message.find(id).topic.messages.count
    (position.to_f/per_page).ceil
  end

  def recipients
    recipients = []
    content.scan(/@+\b(\w+)\b/).uniq.each do |recipient|
      recipients << recipient[0] if User.find_by_username(recipient[0]) != User.current
    end
    recipients
  end
  
  private

  def create_notifications
    recipients.each do |recipient|
      recipient = User.where('lower(username) = ?', recipient.downcase).first
      Notification.create(recipient: recipient, actor: self.user,
        action: 'quote_message', notifiable: self)
    end
  end

  def set_last_message
    self.topic.update(last_message: Time.now)
  end

  def set_user
    self.user = User.current
  end

end
