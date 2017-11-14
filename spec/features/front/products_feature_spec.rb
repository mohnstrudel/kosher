require 'rails_helper'

RSpec.feature "Front products feature spec >", :type => :feature do
  
  before(:each) do
    FactoryBot.create(:general_setting)
  end

  before(:each) do
    @page_size = Rails.application.config.page_size
  end

  before(:each) do
    category = FactoryBot.create(:category)
    @manufacturer = FactoryBot.create(:manufacturer)
    @product = FactoryBot.create(:product, manufacturer: @manufacturer, category: category, title: "Moroshka")
  end

  feature "visit from categories (navigation)" do

    scenario "> should successfully open suppliers page" do
      visit suppliers_path

      expect(page.status_code).to eq(200)
    end

    scenario "> should successfully open trademark page" do
      visit suppliers_path

      find(:xpath, "//a[@href='#{supplier_path(@manufacturer)}']").click

      expect(page.status_code).to eq(200)
    end

    scenario "> should successfully open product page" do
      visit suppliers_path
      find(:xpath, "//a[@href='#{supplier_path(@manufacturer)}']").click
      find(:xpath, "//a[@href='#{supplier_product_path(@manufacturer, @product)}']").click

      expect(page.status_code).to eq(200)
    end
  end

  feature "should have content on show page" do
    scenario ">" do
      visit supplier_product_path(@manufacturer, @product)

      expect(page).to have_content("Moroshka")
    end
  end

  feature "friendly id" do
    scenario "should be correct for product" do
      product = FactoryBot.create(:product, title: "Мороша сладкая")

      visit product_path(product)
      expect(page).to have_current_path('/products/morosha-sladkaya')
    end

    scenario "should be correct for manufacturer and product" do
      manuf = FactoryBot.create(:manufacturer, title: "Саб Зиро")
      product = FactoryBot.create(:product, title: "Мороша горькая", manufacturer: manuf)

      visit supplier_product_path(manuf, product)

      expect(page).to have_current_path('/suppliers/sab-ziro/morosha-gorkaya')
    end
  end
end