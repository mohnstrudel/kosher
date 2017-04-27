require "rails_helper"

RSpec.feature "Kosher products controller", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  scenario "saves the title right" do
    product = FactoryGirl.create(:product, title: "Vodka Moroshka")
    visit admin_products_path

    # fill_in "Name", :with => "My Widget"
    # click_button "Create Widget"
    # save_and_open_page
    expect(page).to have_content("Vodka Moroshka")
    
    # expect(page).to have_no_xpath("//*[@class='pagination']//a[text()='2']")
  end

  scenario "visiting edit path" do
    FactoryGirl.create(:category, title: "First", id: 45)
    category = FactoryGirl.create(:category, title: "Death Water", id: 166)
    product = FactoryGirl.create(:product, description: "Figaro left the house", category_id: category.id)
    
    visit edit_admin_product_path(product)

    expect(page).to have_content("Figaro left the house")
    expect(find(:css, 'select#product_category_id').value).to eq('166')
    
    # expect(page).to have_content("Figaro left the house")
  end
end