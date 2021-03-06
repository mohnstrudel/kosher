require 'rails_helper'

RSpec.feature "Recipe front feature spec >", :type => :feature do
  before(:each) do
    FactoryBot.create(:general_setting)
  end

  feature 'show page >' do
    scenario "show recipe ingredients" do
      recipe_category = FactoryBot.create(:recipe_category)
      recipe = FactoryBot.create(:recipe, recipe_category: recipe_category)
      
      ingredent_1 = FactoryBot.create(:ingredient, title: 'Тар-Тар')
      ingredent_2 = FactoryBot.create(:ingredient, title: 'Карпачатка')

      recipe.recipe_ingredients.create(ingredient_id: ingredent_1.id, amount: "Пятьсот столовых ложек")
      recipe.recipe_ingredients.create(ingredient_id: ingredent_2.id, amount: "Тыща грамм")

      visit recipe_category_recipe_path(recipe_category, recipe)
      
      expect(find('ul.g-text-block__ul_recipe')).to have_selector('li', count: 2)

    end
  end
end
  