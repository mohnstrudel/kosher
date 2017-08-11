require 'rails_helper'

RSpec.describe Recipe, type: :model do
  
  describe "validating recipe category" do
    it "is not valid without category" do
      recipe = FactoryGirl.build(:recipe, recipe_category: nil)
      expect(recipe).not_to be_valid
    end

    it "is not valid without title" do
      recipe = FactoryGirl.build(:recipe, title: nil)
      expect(recipe).not_to be_valid
    end

    it "is valid with title and category" do
      recipe = FactoryGirl.create(:recipe)
      expect(recipe).to be_valid
    end
  end

  context "ingredients" do
    it "saves multiple ingredients" do
      recipe = FactoryGirl.build(:recipe)
      ingredient = FactoryGirl.create(:ingredient)
      ingredient_2 = FactoryGirl.create(:ingredient)

      recipe.recipe_ingredients.build(ingredient_id: ingredient.id, amount: "500 hello")
      recipe.recipe_ingredients.build(ingredient_id: ingredient_2.id, amount: "23 souls")
      
      recipe.save
      expect(recipe.ingredients.count).to eq(2)
    end
  end
end
