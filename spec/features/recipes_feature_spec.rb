require "rails_helper"

RSpec.feature "Recipes feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
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
      FactoryGirl.create(:recipe, title: "Holly Molly")
      visit admin_recipes_path
      expect(page).to have_content("Holly Molly")

      within "table" do
        click_link("Edit", :match => :first)
        # find('a[href="/admin/recipes/1/edit"]').click
      end

      fill_in "recipe_title", with: "Shitty Dizzy"
      find("input[type='submit']").click
      visit admin_recipes_path

      expect(page).to have_content("Shitty Dizzy")
      expect(page).not_to have_content("Holly Molly")
    end
  end
end