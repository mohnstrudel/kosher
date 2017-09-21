require 'rails_helper'

RSpec.feature "Front manufacturers feature spec >", :type => :feature do

  before(:each) do
    FactoryGirl.create(:general_setting)
  end
  
  before(:each) do
    @page_size = Rails.application.config.page_size
  end

  before(:each) do
    @manufacturer = FactoryGirl.create(:manufacturer, title: "Dabby Johnes", description: "Lunatik Ship forwarding")
    @product_1 = FactoryGirl.create(:product, manufacturer: @manufacturer, title: "Moroshka")
    @product_2 = FactoryGirl.create(:product, manufacturer: @manufacturer, title: "Green Arrow")
  end

  feature "checking content for the trademark" do

    scenario "> should have the product list on show page" do
      visit supplier_path(@manufacturer)

      expect(find('ul.g-tm__products-list.g-tm-products')).to have_selector('li', count: 2)
    end

    scenario "> should have other content right" do
      visit supplier_path(@manufacturer)

      expect(page).to have_content("Dabby Johnes")
      expect(page).to have_content("Lunatik Ship forwarding")
    end
  end

  feature "friendly id" do
    scenario "chould be correct for supplier_path" do
      manuf = FactoryGirl.create(:manufacturer, title: "Скорпушечка")
      visit supplier_path(manuf)

      expect(page).to have_current_path('/suppliers/skorpushechka')
    end
  end
end