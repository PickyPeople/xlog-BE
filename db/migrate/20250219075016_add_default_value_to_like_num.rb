class AddDefaultValueToLikeNum < ActiveRecord::Migration[8.0]
  def change
    change_column_default :posts, :likeNum, from: nil, to: 0
  end
end
