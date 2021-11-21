class Host < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :genres, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :postal_code, presence: true
  validates :telephone_number, presence: true
  validates :is_active, inclusion: [true, false]

  def self.search(keyword)
    where(['name like? ', "%#{keyword}%"])
  end
end
