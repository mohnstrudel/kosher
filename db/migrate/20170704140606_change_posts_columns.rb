class ChangePostsColumns < ActiveRecord::Migration[5.1]
    

  def change
    remove_column :posts, :datetime
  end
end
