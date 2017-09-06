class AddSlugToRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :recipe_categories, :slug, :string
    add_index :recipe_categories, :slug, unique: true
  end
end
