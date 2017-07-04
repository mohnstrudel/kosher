class AddPublishedAtToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :published_at, :string
    add_column :posts, :datetime, :string
  end
end
