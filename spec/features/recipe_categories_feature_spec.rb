require "rails_helper"

RSpec.feature "Recipe categories feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryBot.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryBot.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature 'navigation accessability >' do
    scenario 'click all recipe categories link' do
      visit admin_path

      # find(:xpath, "//a[@href='/admin/']").click
      find("a[href='#{admin_recipe_categories_path}']").click
      expect(page).to have_current_path(admin_recipe_categories_path)
      expect(page).to have_content("Recipe_categories here")
    end
  end

  feature "crud methods >" do
    
    scenario 'index' do
      FactoryBot.create(:recipe_category)
      visit admin_recipe_categories_path
      expect(page.all('table#listing_table tr').count).to eq(2)
    end
    
    scenario 'create' do
      visit admin_recipe_categories_path
      click_link('new_entry')
      
      fill_in 'recipe_category_title', with: "Grizzly Bears Ltd."
      
      expect { 
        # find("input[type='submit']").click 
        first("input[type='submit']").click 
        }.to change(RecipeCategory, :count).by(1)
    end

    scenario 'edit' do
      rc = FactoryBot.create(:recipe_category, title: "Holly Molly")
      visit admin_recipe_categories_path
      expect(page).to have_content("Holly Molly")

      click_link "edit_list_item_#{rc.id}"

      fill_in "recipe_category_title", with: "Shitty Dizzy"
      # find("input[type='submit']").click
      first("input[type='submit']").click 
      visit admin_recipe_categories_path

      expect(page).to have_content("Shitty Dizzy")
      expect(page).not_to have_content("Holly Molly")
    end
  end
end