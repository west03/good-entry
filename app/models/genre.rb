class Genre < ApplicationRecord

  has_many :events, dependent: :destroy
  belongs_to :host

  validates :name, presence: true

end
