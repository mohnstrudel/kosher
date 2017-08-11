require "rails_helper"

RSpec.feature "Recipes feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature "recipe ingredients >" do
    scenario 'when editing' do
      recipe = FactoryGirl.create(:recipe)
      FactoryGirl.create(:ingredient, title: 'Dooge')
      visit edit_admin_recipe_path(recipe)

      select 'Dooge', from: 'recipe_recipe_ingredients_attributes_0_ingredient_id'
      fill_in 'recipe_recipe_ingredients_attributes_0_amount', with: '500ml'

      find("input[type='submit']").click

      expect(recipe.ingredients.count).to eq(1)
    end
  end

  feature "crud methods >" do
    
    scenario 'index' do
      FactoryGirl.create(:recipe)
      visit admin_recipes_path
      expect(page.all('table#listing_table tr').count).to eq(2)
    end
    
    scenario 'create' do
      FactoryGirl.create(:recipe_category, title: 'Awesome Cat')
      visit admin_recipes_path
      click_link('new_entry')

      select "Awesome Cat", from: 'recipe_recipe_category_id'
      fill_in 'recipe_title', with: "Grizzly Bears Ltd."
      
      expect { find("input[type='submit']").click }.to change(Recipe, :count).by(1)
    end

    scenario 'edit' do
      recipe = FactoryGirl.create(:recipe, title: "Holly Molly")
      visit admin_recipes_path
      expect(page).to have_content("Holly Molly")

      click_link "edit_list_item_#{recipe.id}"

      fill_in "recipe_title", with: "Shitty Dizzy"
      find("input[type='submit']").click
      visit admin_recipes_path

      expect(page).to have_content("Shitty Dizzy")
      expect(page).not_to have_content("Holly Molly")
    end
  end

  feature "bulk delete >" do
    scenario "reduce recipe amount by 2" do
      recipe_1 = FactoryGirl.create(:recipe, title: "Grizzly Bears Ltd.")
      recipe_2 = FactoryGirl.create(:recipe, title: "Shitty Dizzy")
      recipe_3 = FactoryGirl.create(:recipe)
      visit admin_recipes_path
      
      find(:css, "input[type=checkbox][value='#{recipe_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{recipe_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Recipe, :count).by(-2)
      # save_and_open_page
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end
  end
end