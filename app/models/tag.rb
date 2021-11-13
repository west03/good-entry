class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :events, through: :tag_maps


  validates :name, presence: true

  def self.search(keyword)
    if keyword[0] == '#'
      tag = Tag.where(name: keyword.delete_prefix("#"))
      tag[0].events
    else
      Event.all
    end
  end

end
