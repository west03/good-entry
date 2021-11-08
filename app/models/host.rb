class Host < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events
  has_many :genres
  
  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true
  validates :telephone_number, presence: true
  validates :is_active, presence: true
  
end
