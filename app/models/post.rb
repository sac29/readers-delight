class Post < ApplicationRecord
  self.table_name = "posts"

  #fields
  # t.text :content
  # t.string :title
  # t.string :posted_at
  # t.integer :read_time
  #
  # t.uuid :creator_id, foreign_key: true
  # t.string :tags, array: true, default: []

  #associations
  belongs_to :creator, class_name: 'Creator'

  #validations
  validates :title, presence: true
  validates :creator_id, presence: true
end
