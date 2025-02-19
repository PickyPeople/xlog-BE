class RemoveImgFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :img, :string
  end
end
