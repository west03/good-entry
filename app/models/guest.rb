class Guest < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :event_entries
  has_many :comments
  has_many :likes

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true
  validates :telephone_number, presence: true
  validates :is_active, presence: true

  def already_liked?(event)
    self.likes.exists?(event_id: event.id)
  end

  def self.search(keyword)
    where(["last_name like? OR first_name like? ", "%#{keyword}%",  "%#{keyword}%"])
  end

end
