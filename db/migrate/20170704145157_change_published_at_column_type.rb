class ChangePublishedAtColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :published_at, :string
  end
end
