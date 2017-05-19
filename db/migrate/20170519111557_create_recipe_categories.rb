class CreateRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_categories do |t|
      t.string :title
      t.text :description
      t.string :logo

      t.timestamps
    end
  end
end
