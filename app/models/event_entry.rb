class EventEntry < ApplicationRecord
  belongs_to :guest
  belongs_to :event

end
