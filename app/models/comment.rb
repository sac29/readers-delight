class Comment < ApplicationRecord
  self.table_name = "comments"

  #fields
  # t.uuid :creator_id, foreign_key: true
  # t.uuid :post_id, foreign_key: true
  # t.text :comment

  #associations
  belongs_to :commenter, class_name: 'Creator', foreign_key: 'creator_id'
  belongs_to :post, class_name: 'Post'

  #validations
  validates :creator_id, presence: true
  validates :post_id, presence: true
end
