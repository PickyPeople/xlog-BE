class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :sub
      t.string :img
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.integer :likeNum

      t.timestamps
    end
  end
end
