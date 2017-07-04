class DropPublishedAtForPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :published_at
  end
end
