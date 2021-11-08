class Like < ApplicationRecord
  belongs_to :guest
  belongs_to :event
  
  validates_uniqueness_of :event_id, scope: :guest_id
end
