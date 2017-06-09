require 'rails_helper'

RSpec.feature "(Product) Categories feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature "crud methods" do
    scenario "> creating a subcategory from index page leads to correct new page (containing parent select field)" do
      visit admin_categories_path(sublevel: true)

      click_link('new_entry')

      expect(page).to have_css('#category_parent_id')
    end
  end
end