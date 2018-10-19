class CreateCreators < ActiveRecord::Migration[5.2]
  def change
    create_table :creators, id: :uuid do |t|
      t.string :name, null: false
      t.string :profile_title
      
      t.timestamps
    end
  end
end
