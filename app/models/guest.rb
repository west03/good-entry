class Guest < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :event_entries
  has_many :comments
  has_many :likes
end
