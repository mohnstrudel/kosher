require "rails_helper"

RSpec.feature "Manufacturers feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  before(:each) do
    @main_manufacturer = FactoryGirl.create(:manufacturer, title: "My main manufacturerz")
    @manufacturer_1 = FactoryGirl.create(:manufacturer, parent_id: @main_manufacturer.id, title: "Grizzly Bears Ltd.")
    @manufacturer_2 = FactoryGirl.create(:manufacturer, parent_id: @main_manufacturer.id, title: "Shitty Dizzy")
    @manufacturer_3 = FactoryGirl.create(:manufacturer, parent_id: @main_manufacturer.id, title: "Some Leftovers")
  end

  feature "crud methods >" do
    
    scenario 'create' do
      visit admin_manufacturers_path
      
      # find(:xpath, '//link[@href="/admin/manufacturers/new"]').click
      # find("#new_entry").click
      # page.find("#new_entry").click
      click_link('new_entry')
      
      fill_in 'manufacturer_title', with: "Angry Grizzly Bears Ltd."
      
      expect { 
        # find("input[type='submit']").click 
        first("input[type='submit']").click
        }.to change(Manufacturer, :count).by(1)
      # visit admin_manufacturers_path
    end

    scenario "creating a trademark from index page leads to correct new page (containing parent select field)" do
      visit admin_manufacturers_path(sublevel: true)

      click_link('new_entry')

      expect(page).to have_css('#manufacturer_parent_id')
    end
  end

  feature "bulk delete >" do
    scenario "delete level 2 manufacturers" do
      visit admin_manufacturers_path(sublevel: true)
      
      find(:css, "input[type=checkbox][value='#{@manufacturer_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{@manufacturer_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Manufacturer, :count).by(-2)
      # save_and_open_page
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end

    scenario "delete level 1 manufacturers" do
      main_manufacturer_2 = FactoryGirl.create(:manufacturer, title: "Bin Supraman")
      main_manufacturer_3 = FactoryGirl.create(:manufacturer)
      visit admin_manufacturers_path
      
      find(:css, "input[type=checkbox][value='#{@main_manufacturer.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{main_manufacturer_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        # -5 потому что вместе с родительским лейблом удаляем ещё и 3 дочерних (итого 2 род. плюс 3 доч. - итого минус 5)
        }.to change(Manufacturer, :count).by(-5)
      # save_and_open_page
      expect(page).not_to have_content("My main manufacturerz")
      expect(page).to have_content("Bin Supraman")
    end
  end
end