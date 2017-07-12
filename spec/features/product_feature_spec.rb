require "rails_helper"

RSpec.feature "Products controller", :type => :feature do

  before(:each) {
    @page_size = Rails.application.config.page_size
  }

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end


  feature "testing the CRUD methods >" do

    scenario "create" do
      visit admin_products_path
      expect(page.all('table#listing_table tr').count).to eq(1)
      
      FactoryGirl.create(:product)

      visit admin_products_path

      expect(page.all('table#listing_table tr').count).to eq(2)
    end

    scenario "update" do
      product = FactoryGirl.create(:product)
      product.update(title: "Kenshi")
      visit admin_products_path
      expect(page).to have_content("Kenshi")

      visit edit_admin_product_path(product)
      fill_in 'product_title', with: "Sonya Blade"
      # save_and_open_page
      find("input[type='submit']").click

      visit admin_products_path
      expect(page).not_to have_content("Kenshi")  
      expect(page).to have_content("Sonya Blade")
    end

    scenario "delete" do
      product = FactoryGirl.create(:product)
      visit admin_products_path
      expect { click_link "delete_list_item_#{product.id}" }.to change(Product, :count).by(-1)
    end
  end

  scenario "saves the title right" do
    category = FactoryGirl.create(:category)
    product = FactoryGirl.create(:product, title: "Vodka Moroshka", category: category)
    visit admin_products_path

    # fill_in "Name", :with => "My Widget"
    # click_button "Create Widget"
    # save_and_open_page
    expect(page).to have_content("Vodka Moroshka")
    
    # expect(page).to have_no_xpath("//*[@class='pagination']//a[text()='2']")
  end

  scenario "visiting edit path" do
    FactoryGirl.create(:category, title: "First", id: 45)
    parent_category = FactoryGirl.create(:category)
    category = FactoryGirl.create(:category, title: "Death Water", id: 166, parent_id: parent_category.id)
    product = FactoryGirl.create(:product, description: "Figaro left the house", category_id: category.id)


    
    visit edit_admin_product_path(product)

    expect(page).to have_content("Figaro left the house")
    expect(find(:css, 'select#product_category_id').value).to eq('166')
    
    # expect(page).to have_content("Figaro left the house")
  end

  feature "searching and" do

    before(:each) {
      FactoryGirl.create(:product, title: "Scorpion")
      FactoryGirl.create(:product, description: "Mighty bash scorpion has lauched a hook")
      FactoryGirl.create(:product, title: "Sub Zero")
    }

    scenario "finding all categories' children's products" do
      category = FactoryGirl.create(:category, title: "Category")
      subcategory = FactoryGirl.create(:category, title: "Sub Sub", parent_id: category.id)
      FactoryGirl.create(:product, title: "Subcategory Product", category_id: subcategory.id)
      
      visit admin_products_path
      # 5 потому что заранее создаем 3, плюс в данном сценарии 1 и дефолтно заголовки 
      # занимают одну строку
      expect(page.all('table#listing_table tr').count).to eq(5)

      select "Category", from: "category_id"
      find("input[type='submit'][id='search']").click
      
      expect(page).to have_content("Subcategory Product")
      expect(page).not_to have_content("Scorption")
      expect(page.all('table#listing_table tr').count).to eq(2)
    end

    scenario "finding all manufacturer children's products" do
      # Setup block begin
      manufacturer = FactoryGirl.create(:manufacturer, title: "Manufacturer")
      trademark = FactoryGirl.create(:manufacturer, title: "Trademark", parent_id: manufacturer.id)
      FactoryGirl.create(:product, title: "TM Product", manufacturer_id: trademark.id)
      FactoryGirl.create(:product, title: "Random product")
      # Setup block end
      
      visit admin_products_path
      # 6 потому что заранее создаем 3, плюс в данном сценарии 2 и дефолтно заголовки 
      # занимают одну строку
      if @page_size > (4)
        expect(page.all('table#listing_table tr').count).to eq(6)
      else
        expect(page.all('table#listing_table tr').count).to eq(@page_size+1)
      end

      select "Manufacturer", from: "manufacturer_id"
      find("input[type='submit'][id='search']").click
      
      expect(page).to have_content("TM Product")
      expect(page).not_to have_content("Random product")
      expect(page.all('table#listing_table tr').count).to eq(2)

    end

    scenario "finding two items out of three" do
      visit admin_products_path

      fill_in 'keywords', with: 'scorp'
      find("input[type='submit'][id='search']").click

      expect(page.all('table#listing_table tr').count).to eq(3)

    end

    scenario "finding no items out of three" do
      visit admin_products_path

      fill_in 'keywords', with: 'kenshi'
      find("input[type='submit'][id='search']").click

      expect(page.all('table#listing_table tr').count).to eq(1)
    end

    scenario "finding one item out of three" do
      visit admin_products_path

      fill_in 'keywords', with: 'zero'
      find("input[type='submit'][id='search']").click

      expect(page.all('table#listing_table tr').count).to eq(2)
    end
  end

  feature "filtering the" do

    scenario "incomplete products" do
      product_1 = FactoryGirl.create(:product, title: "Mo bi Dabius")
      product_2 = FactoryGirl.build(:product, title: "Bin Suparman", manufacturer_id: nil)
      product_2.save(validate: false)

      visit admin_products_path

      find(:css, "#incomplete").set(true)
      find("input[type='submit'][id='search']").click
      expect(page.all('table#listing_table tr').count).to eq(2)
      expect(page).to have_content("Bin Suparman")
      expect(page).not_to have_content("Mo bi Dabius")
    end

    scenario "incomplete products with false checkbox" do
      product_1 = FactoryGirl.create(:product, title: "Hurra Di Hussa")
      product_2 = FactoryGirl.build(:product, title: "Bin Suparman", manufacturer_id: nil)
      product_2.save(validate: false)

      visit admin_products_path

      find(:css, "#incomplete").set(false)
      find("input[type='submit'][id='search']").click
      expect(page.all('table#listing_table tr').count).to eq(3)
      expect(page).to have_content("Bin Suparman")
      expect(page).to have_content("Hurra Di Hussa")
    end
    
    scenario "manufacturers created, one result for right manufacturer" do
      mf = FactoryGirl.create(:manufacturer, title: "Cringy Meat Ltd.", id: 777)
      product = FactoryGirl.create(:product, title: "Some serious meat", manufacturer_id: 777)
      FactoryGirl.create(:product, title: "Not on menu")

      visit admin_products_path

      select "Cringy Meat Ltd.", from: "manufacturer_id"
      find("input[type='submit'][id='search']").click
      
      expect(page).to have_content("Some serious meat")
      expect(page).not_to have_content("Not on menu")
      expect(page.all('table#listing_table tr').count).to eq(2)

      # fill_in 'manufacturer_id', with: ""
    end

    scenario "manufacturers created, no results for wrong manufacturer select" do
      mf_1 = FactoryGirl.create(:manufacturer)
      mf_2 = FactoryGirl.create(:manufacturer)
      product = FactoryGirl.create(:product, title: "Scorpion", manufacturer_id: mf_1.id)

      visit admin_products_path

      select mf_2.title, from: "manufacturer_id"
      find("input[type='submit'][id='search']").click

      expect(page).not_to have_content("Scorpion")
      expect(page.all('table#listing_table tr').count).to eq(1)
    end

    scenario "category is set up right, no results if there are no items" do
      category_1 = FactoryGirl.create(:category, title: "Right Cat", id: 44)
      category_2 = FactoryGirl.create(:category, title: "Wrong Cat", id: 55)
      product = FactoryGirl.create(:product, title: "Scorpion", category_id: category_1.id, id: 912)
      
      visit admin_products_path

      select "Wrong Cat", from: "category_id"
      find("input[type='submit'][id='search']").click
      expect(page).not_to have_content("Scorpion")
      expect(page.all('table#listing_table tr').count).to eq(1)
    end

    scenario "category is set up right, one result for the right category" do
      category_1 = FactoryGirl.create(:category, title: "Right Cat", id: 44)
      product = FactoryGirl.create(:product, title: "Scorpion", category_id: category_1.id, id: 912)
      FactoryGirl.create(:product, title: "Sub Zero")
      
      visit admin_products_path

      select "Right Cat", from: "category_id"
      find("input[type='submit'][id='search']").click

      expect(page).to have_content("Scorpion")
      expect(page).not_to have_content("Sub Zero")
      expect(page.all('table#listing_table tr').count).to eq(2)
    end
  end

  feature "bulk delete >" do
    scenario "reduce product amount by 2" do
      product_1 = FactoryGirl.create(:product, title: "Grizzly Bears Ltd.")
      product_2 = FactoryGirl.create(:product, title: "Shitty Dizzy")
      product_3 = FactoryGirl.create(:product)
      visit admin_products_path
      
      find(:css, "input[type=checkbox][value='#{product_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{product_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Product, :count).by(-2)
      # save_and_open_page
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end
  end
end