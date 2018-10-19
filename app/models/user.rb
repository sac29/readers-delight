class User < ApplicationRecord
  self.table_name = "users"

  # t.string :name, null: false
  # t.string :email, null: false
  # t.string :password, null: false
  # t.integer :mobile
  # t.string :gender
  # t.date :dob

  #validations
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
