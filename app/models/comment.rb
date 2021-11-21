class Comment < ApplicationRecord
  belongs_to :guest
  belongs_to :event

  validates :comment_content, presence: true
  
end
