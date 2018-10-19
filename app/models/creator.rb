class Creator < ApplicationRecord
  self.table_name = "creators"

  #fields
  # t.string :name, null: false
  # t.string :profile_title

  has_many :posts

  validates :name, presence: true

end
