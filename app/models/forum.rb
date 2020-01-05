class Forum < ApplicationRecord

  belongs_to :category
  belongs_to :role

  has_many :topics

  def count_topics
    self.topics.count
  end

  def count_messages
    self.topics.joins(:messages).where('messages.topic_id = topics.id').count
  end

end
