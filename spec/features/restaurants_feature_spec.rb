require "rails_helper"

RSpec.feature "Restaurants feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature "crud methods >" do
    scenario "create" do
      # FactoryGirl.create(:recipe_category, title: 'Awesome Cat')
      visit admin_restaurants_path
      click_link('new_entry')

      # select "Awesome Cat", from: 'recipe_recipe_category_id'
      fill_in 'restaurant_title', with: "Grizzly Bears Ltd."
      
      expect { find("input[type='submit']").click }.to change(Restaurant, :count).by(1)
    end
  end

  feature "bulk delete" do

    scenario "reduce amount of restaurants by 2" do
      rest_1 = FactoryGirl.create(:restaurant, title: "Grizzly Bears Ltd.")
      rest_2 = FactoryGirl.create(:restaurant, title: "Shitty Dizzy")
      rest_3 = FactoryGirl.create(:restaurant)
      
      visit admin_restaurants_path
      # save_and_open_page
      find(:css, "input[type=checkbox][value='#{rest_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{rest_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Restaurant, :count).by(-2)

      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end
  end
end