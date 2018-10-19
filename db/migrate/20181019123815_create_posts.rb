class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts, id: :uuid do |t|
      t.text :content
      t.string :title
      t.string :posted_at
      t.integer :read_time

      t.uuid :creator_id, foreign_key: true
      t.string :tags, array: true, default: []

      t.timestamps
    end
    add_index('posts', 'creator_id')
  end
end
