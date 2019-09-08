class Permission < ApplicationRecord
  belongs_to :role, optional: true
  

  
end