class Forum < ApplicationRecord

  belongs_to :category
  belongs_to :role

  has_many :topics

end
