require 'rails_helper'

RSpec.feature "(Product) Categories feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  before(:each) do
    @main_category = FactoryGirl.create(:category, title: "My main categoriez")
    @category_1 = FactoryGirl.create(:category, parent_id: @main_category.id, title: "Grizzly Bears Ltd.")
    @category_2 = FactoryGirl.create(:category, parent_id: @main_category.id, title: "Shitty Dizzy")
    @category_3 = FactoryGirl.create(:category, parent_id: @main_category.id, title: "Some Leftovers")
  end

  feature "crud methods" do
    scenario "> creating a subcategory from index page leads to correct new page (containing parent select field)" do
      visit admin_categories_path(sublevel: true)

      click_link('new_entry')

      expect(page).to have_css('#category_parent_id')
    end
  end

  feature "bulk delete >" do
    scenario "delete level 2 categories" do
      visit admin_categories_path(sublevel: true)
      
      find(:css, "input[type=checkbox][value='#{@category_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{@category_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Category, :count).by(-2)
      # save_and_open_page
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end

    scenario "delete level 1 categories" do
      main_category_2 = FactoryGirl.create(:category, title: "Bin Supraman")
      main_category_3 = FactoryGirl.create(:category)
      visit admin_categories_path
      
      find(:css, "input[type=checkbox][value='#{@main_category.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{main_category_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        # -5 потому что вместе с родительским лейблом удаляем ещё и 3 дочерних (итого 2 род. плюс 3 доч. - итого минус 5)
        }.to change(Category, :count).by(-5)
      # save_and_open_page
      expect(page).not_to have_content("My main categoriez")
      expect(page).to have_content("Bin Supraman")
    end
  end
end