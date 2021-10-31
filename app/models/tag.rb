class Tag < ApplicationRecord
  has_many :events
  has_many :tag_maps
end
