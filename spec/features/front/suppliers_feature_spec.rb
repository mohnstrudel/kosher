require 'rails_helper'

RSpec.feature "Front suppliers feature spec >", :type => :feature do
  
  before(:each) do
    FactoryGirl.create(:general_setting)
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
      # ТМ только для выбранной аппа категории
      category = FactoryGirl.create(:category)
      manuf = FactoryGirl.create(:manufacturer)
      product = FactoryGirl.create(:product, category: category, manufacturer: manuf)
      FactoryGirl.create_list(:manufacturer, 2)

      visit suppliers_path(category: category.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
    end

    scenario "should list only manufacturers for a given lower category and no given upper category" do
      # ТМ только для выбранной подкатегории (без аппы категории)
      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcat = FactoryGirl.create(:category, title: "VODKA", parent_id: category.id)
      manuf_1 = FactoryGirl.create(:manufacturer, title: "SCORPION")
      manuf_2 = FactoryGirl.create(:manufacturer, title: "SUB ZERO")
      product = FactoryGirl.create(:product, category: subcat, manufacturer: manuf_1)
      product = FactoryGirl.create(:product, category: category, manufacturer: manuf_2)
      FactoryGirl.create_list(:manufacturer, 2)

      visit suppliers_path(subcategory: subcat.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
      
      within("ul") do
        expect(page).to have_content("SCORPION")
        expect(page).not_to have_content("SUB ZERO")
      end
    end

    scenario "list trademarks only for selected manufacturer, upper and lower category" do
      # Должно быть 2 торговые марки для выбранной категории, подкатегории и производителя
      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcat = FactoryGirl.create(:category, title: "VODKA", parent_id: category.id)
      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorps trademark", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "ryaj ryu", parent_id: manuf.id)
      
      manuf_2 = FactoryGirl.create(:manufacturer, title: "SUB ZERO")
      tm_2_1 = FactoryGirl.create(:manufacturer, title: "Extra thicc", parent_id: manuf_2.id)
      
      FactoryGirl.create(:product, manufacturer: tm_1, category: subcat)
      FactoryGirl.create(:product, manufacturer: tm_2, category: subcat)
      FactoryGirl.create(:product, manufacturer: tm_2_1, category: subcat)

      visit suppliers_path(category: category.id, subcategory: subcat.id, manufacturer: manuf.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 2)
      
      within("ul") do
        expect(page).to have_content("scorps trademark")
        expect(page).to have_content("ryaj ryu")
        expect(page).not_to have_content("SUB ZERO")
        expect(page).not_to have_content("Extra thicc")
      end
    end

    scenario "list trademarks only for selected manufacturer" do
      # Показываем ТМ для выбранного производителя

      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorps trademark", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "bla car")
      FactoryGirl.create(:product, manufacturer: tm_1)
      FactoryGirl.create(:product, manufacturer: tm_2)

      visit suppliers_path(manufacturer: manuf.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)
      
      within("ul") do
        expect(page).to have_content("scorps trademark")
        expect(page).not_to have_content("bla car")
      end
    end

    scenario "list trademarks only for selected upper and lower category" do
      # Должно быть 3 торговые марки для выбранной категории и подкатегории
      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcat = FactoryGirl.create(:category, title: "VODKA", parent_id: category.id)
      category_2 = FactoryGirl.create(:category, title: "KOSMONAFT")
      subcat_2 = FactoryGirl.create(:category, title: "SPACESHIP", parent_id: category_2.id)
      
      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorps trademark", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "ryaj ryu", parent_id: manuf.id)
      tm_3 = FactoryGirl.create(:manufacturer, title: "johnny cage", parent_id: manuf.id)
      
      manuf_2 = FactoryGirl.create(:manufacturer, title: "SUB ZERO")
      tm_2_1 = FactoryGirl.create(:manufacturer, title: "Extra thicc", parent_id: manuf_2.id)
      
      FactoryGirl.create(:product, manufacturer: tm_1, category: subcat)
      FactoryGirl.create(:product, manufacturer: tm_2, category: subcat)
      FactoryGirl.create(:product, manufacturer: tm_3, category: subcat)

      FactoryGirl.create(:product, manufacturer: tm_3, category: subcat_2)

      visit suppliers_path(category: category.id, subcategory: subcat.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 3)
      
      within("ul") do
        expect(page).to have_content("scorps trademark")
        expect(page).to have_content("ryaj ryu")
        expect(page).to have_content("johnny cage")

        expect(page).not_to have_content("SUB ZERO")
        expect(page).not_to have_content("Extra thicc")
      end
    end

    scenario "list trademarks with selected upper category" do
      # ТМ для знаков кашрута + аппа категория
      category = FactoryGirl.create(:category, title: "ALKONAFT")
      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      label = FactoryGirl.create(:label)
      sublabel = FactoryGirl.create(:label, parent_id: label.id)

      product = FactoryGirl.create(:product, category: category, manufacturer: manuf, label: sublabel)
      FactoryGirl.create_list(:manufacturer, 3)

      visit suppliers_path(category: category.id, sign: sublabel.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)

      within("ul") do
        expect(page).to have_content("SCORPION")
      end

    end

    scenario "list trademarks" do
      # ТМ для знаков кашрута + аппа категория + подкатегория

      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcategory = FactoryGirl.create(:category, title: "WISKEY", parent_id: category.id)
      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorp tm_1", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "scorp tm_2", parent_id: manuf.id)
      label = FactoryGirl.create(:label)
      sublabel = FactoryGirl.create(:label, parent_id: label.id)

      product = FactoryGirl.create(:product, category: subcategory, manufacturer: tm_1, label: sublabel)
      product = FactoryGirl.create(:product, category: subcategory, manufacturer: tm_2, label: sublabel)
      FactoryGirl.create_list(:manufacturer, 3)

      visit suppliers_path(category: category.id, subcategory: subcategory.id, sign: sublabel.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 2)

      within("ul") do
        expect(page).to have_content("scorp tm_1")
        expect(page).to have_content("scorp tm_2")

        expect(page).not_to have_content("SCORPION")
      end
    end

    scenario "list trademarks" do
      # ТМ для знаков кашрута + аппа категория + подкатегория + производитель

      category = FactoryGirl.create(:category, title: "ALKONAFT")
      subcategory = FactoryGirl.create(:category, title: "WISKEY", parent_id: category.id)
      manuf = FactoryGirl.create(:manufacturer, title: "SCORPION")
      tm_1 = FactoryGirl.create(:manufacturer, title: "scorp tm_1", parent_id: manuf.id)
      tm_2 = FactoryGirl.create(:manufacturer, title: "scorp tm_2", parent_id: manuf.id)
      label = FactoryGirl.create(:label)
      sublabel = FactoryGirl.create(:label, parent_id: label.id)

      product = FactoryGirl.create(:product, category: subcategory, manufacturer: tm_1, label: sublabel)
      product = FactoryGirl.create(:product, category: subcategory, manufacturer: tm_2, label: sublabel)
      FactoryGirl.create_list(:manufacturer, 3)

      visit suppliers_path(category: category.id, subcategory: subcategory.id, manufacturer: tm_1.id, sign: sublabel.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 1)

      within("ul") do
        expect(page).to have_content("scorp tm_1")
        
        expect(page).not_to have_content("scorp tm_2")
        expect(page).not_to have_content("SCORPION")
      end
    end

    scenario "list trademarks for one selected label" do
      # ТМ для знаков кашрута онли
      label = FactoryGirl.create(:label)
      sublabel = FactoryGirl.create(:label, parent_id: label)

      tm_1 = FactoryGirl.create(:manufacturer, parent_id: 1, title: "selyodka")
      tm_2 = FactoryGirl.create(:manufacturer, parent_id: 1, title: "barabylka")

      FactoryGirl.create(:product, manufacturer: tm_1, label: sublabel)
      FactoryGirl.create(:product, manufacturer: tm_2, label: sublabel)

      visit suppliers_path(sign: sublabel.id)

      expect(find('ul.g-products-wrapper')).to have_selector('li', count: 2)

      within("ul") do
        expect(page).to have_content("barabylka")
        expect(page).to have_content("selyodka")
      end
    end

    scenario "list trademarks for multiple selected labels" do
    end
  end
end