require 'rails_helper'

RSpec.feature "Front suppliers feature spec >", :type => :feature do
  
  before(:each) do
    
  end

  before(:each) do
    @page_size = Rails.application.config.page_size
  end

  feature "index page >" do
    scenario "should list all manufacturer without filter params" do
      FactoryGirl.create_list(:manufacturer, 5)
      visit suppliers_path


      if @page_size > 5
        expect(find('ul.g-products-wrapper')).to have_selector('li', count: 5)
      else
        expect(find('ul.g-products-wrapper')).to have_selector('li', count: @page_size)
      end
    end

    scenario "should list only manufacturer for a given upper category" do
      category = FactoryGirl.create(:category)
      manuf = FactoryGirl.create(:manufacturer)
      product = FactoryGirl.create(:product, category: category, manufacturer: manuf)
      FactoryGirl.create_list(:manufacturer, 2)

      visit suppliers_path(upper_category: category.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
    end

    scenario "should list only manufacturers for a given lower category and no given upper category" do
      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcat = FactoryGirl.create(:category, title: "VODKA", parent_id: category.id)
      manuf_1 = FactoryGirl.create(:manufacturer, title: "SCORPION")
      manuf_2 = FactoryGirl.create(:manufacturer, title: "SUB ZERO")
      product = FactoryGirl.create(:product, category: subcat, manufacturer: manuf_1)
      product = FactoryGirl.create(:product, category: category, manufacturer: manuf_2)
      FactoryGirl.create_list(:manufacturer, 2)

      visit suppliers_path(category_id: subcat.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
      
      within("ul") do
        expect(page).to have_content("SCORPION")
        expect(page).not_to have_content("SUB ZERO")
      end
    end

    scenario "list trademarks only for selected manufacturer, upper and lower category" do
    end

    scenario "list trademarks only for selected manufacturer" do

      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorps trademark", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "bla car")
      FactoryGirl.create(:product, manufacturer: tm_1)
      FactoryGirl.create(:product, manufacturer: tm_2)

      visit suppliers_path(manufacturer_id: manuf.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
      
      within("ul") do
        expect(page).to have_content("scorps trademark")
        expect(page).not_to have_content("bla car")
      end

    end
  end

end