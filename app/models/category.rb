class Category < ApplicationRecord

  has_many :forums

  def count_forums
    self.forums.count
  end

end
