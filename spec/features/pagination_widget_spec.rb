require "rails_helper"

RSpec.feature "Widget management", :type => :feature do
  
  before(:each) {  
    amount = Rails.application.config.page_size
    amount.times { FactoryBot.create(:shop) }
  }

  before(:each) {
    login_as(FactoryBot.create(:user, superadmin: true), :scope => :user)
  }

  scenario "with entries == config.page_size" do
    
    visit admin_shops_path

    # fill_in "Name", :with => "My Widget"
    # click_button "Create Widget"

    # expect(page).to have_text("Widget was successfully created.")
    # save_and_open_page
    expect(page).to have_no_xpath("//*[@class='pagination']//a[text()='2']")
  end

  scenario "with entries > config.page_size" do
    FactoryBot.create(:shop)
    visit admin_shops_path
    expect(page).to have_xpath("//*[@class='pagination']//a[text()='2']")
  end

  scenario "with entries > config.page_size it correctly redirects to next page" do
    FactoryBot.create(:shop)
    visit admin_shops_path
    find("//*[@class='pagination']//a[text()='2']").click
    expect(page.status_code).to eq(200)
  end
end