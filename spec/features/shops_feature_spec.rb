require "rails_helper"

RSpec.feature "Shops feature spec >", :type => :feature do

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
      visit admin_shops_path
      click_link('new_entry')

      # select "Awesome Cat", from: 'recipe_recipe_category_id'
      fill_in 'shop_title', with: "Grizzly Bears Ltd."
      
      expect { 
        first("input[type='submit']").click
        # find("input[type='submit']").click 
        }.to change(Shop, :count).by(1)
    end
  end

  feature "bulk delete" do

    scenario "reduce amount of shop by 2" do
      shop_1 = FactoryGirl.create(:shop, title: "Grizzly Bears Ltd.")
      shop_2 = FactoryGirl.create(:shop, title: "Shitty Dizzy")
      shop_3 = FactoryGirl.create(:shop)
      
      visit admin_shops_path
      # save_and_open_page
      find(:css, "input[type=checkbox][value='#{shop_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{shop_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Shop, :count).by(-2)
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end
  end
end