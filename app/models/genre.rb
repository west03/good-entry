class Genre < ApplicationRecord
  has_many :events
  belongs_to :host
end
