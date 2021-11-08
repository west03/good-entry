class Comment < ApplicationRecord
  belongs_to :guest
  belongs_to :event

  validates :commint_content, presence: true

end
