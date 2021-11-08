class Tag < ApplicationRecord
  has_many :events
  has_many :tag_maps

  validates :name, presence: true

end
