class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: :uuid do |t|
      t.uuid :creator_id, foreign_key: true
      t.uuid :post_id, foreign_key: true
      t.text :comment

      t.timestamps

    end
  end
end
