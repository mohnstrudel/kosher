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
end
