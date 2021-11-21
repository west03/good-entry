class Event < ApplicationRecord

  has_many :event_entries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  belongs_to :host
  belongs_to :genre

  validates :title, presence: true
  validates :introduction, presence: true
  validates :prefecture, presence: true
  validates :address, presence: true
  validates :date_and_time, presence: true
  validates :holding_flag, presence: true
  validates :tag_maps, presence: true

  attachment :image

  enum prefecture: {
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46, 沖縄県: 47
  }

  enum holding_flag: {
    作成中: 0, 募集中: 1, 募集終了: 2, 延期: 3, 中止: 4
  }

  def self.search(keyword)
    where(['title like? OR introduction like?', "%#{keyword}%", "%#{keyword}%"])
  end

  def save_event_tag(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      event_tag = Tag.find_or_create_by(name: new)
      self.tags << event_tag
    end
  end
  
end
