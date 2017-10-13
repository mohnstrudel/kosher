class AddRecipesToSeos < ActiveRecord::Migration[5.1]
  def change
    add_reference :seos, :recipe, foreign_key: true
    add_reference :seos, :recipe_category, foreign_key: true
  end
end
