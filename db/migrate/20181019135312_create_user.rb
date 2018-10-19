class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.integer :mobile
      t.string :gender
      t.date :dob

      t.timestamps
    end
  end
end
