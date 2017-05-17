require "rails_helper"

RSpec.feature "Manufacturers feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature "crud methods >" do
    
    scenario 'create' do
      visit admin_manufacturers_path
      
      # find(:xpath, '//link[@href="/admin/manufacturers/new"]').click
      # find("#new_entry").click
      # page.find("#new_entry").click
      click_link('new_entry')
      
      fill_in 'manufacturer_title', with: "Grizzly Bears Ltd."
      
      expect { find("input[type='submit']").click }.to change(Manufacturer, :count).by(1)
      
      # visit admin_manufacturers_path
    end
  end
end