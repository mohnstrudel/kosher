require 'rails_helper'

describe "Products API" do
  context "displaying only products" do

    before(:each) do
      @category = FactoryGirl.create(:category)
    end
    it "lists all products" do
      FactoryGirl.create_list(:product, 6, category_id: @category.id)

      get '/v1/products'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(6)
    end

    it "shows a certain product" do
      product = FactoryGirl.create(:product, category_id: @category.id)

      get "/v1/products/#{product.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success

      expect(json['data']['id'].to_i).to eq(product.id)
    end

    describe "shows specific data for certain product" do

      before(:each) do
        @category = FactoryGirl.create(:category, title: "Symbios")
        @manufacturer = FactoryGirl.create(:manufacturer, title: "Supersonic")
        @label = FactoryGirl.create(:label, title: "Ho Sho M")
        @product = FactoryGirl.create(:product, title: "Rspec Product", description: "Rspec description", category: @category, manufacturer: @manufacturer, label: @label)
      end
      it "has the right title" do
        get "/v1/products/#{@product.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['title']).to eq("Rspec Product")
      end

      it "has the right description" do
        get "/v1/products/#{@product.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['description']).to eq("Rspec description")
      end

      it "has no manufacturer, category and label" do
        get "/v1/products/#{@product.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['manufacturer']['title']).to eq("Supersonic")
        expect(json['data']['attributes']['category']['title']).to eq("Symbios")
        expect(json['data']['attributes']['label']['title']).to eq("Ho Sho M")
      end
    end
  end

  context "displaying product categories" do
    it "lists all categories" do
      FactoryGirl.create_list(:category, 9)

      get '/v1/categories'

      json = JSON.parse(response.body)
      expect(response).to be_success
      expect(json['data'].length).to eq(9)
    end

    it "shows a category" do
      category = FactoryGirl.create(:category)
      get "/v1/categories/#{category.id}"
      json = JSON.parse(response.body)
      expect(json['data']['id'].to_i).to eq(category.id)
    end

    describe "and showing specific data for certain category" do
      before(:each) do
        @category = FactoryGirl.create(:category, title: "Rspec Title", description: "Rspec Desc")
      end

      it "> has the right title" do
        get "/v1/categories/#{@category.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['title']).to eq("Rspec Title")
      end
      it "> has the right description" do
        get "/v1/categories/#{@category.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['description']).to eq("Rspec Desc")
      end
    end

    describe "has correct subcategory relationship" do
      before(:each) do
        @category_1 = FactoryGirl.create(:category)
        @category_2 = FactoryGirl.create(:category, parent_id: @category_1.id, title: "subcat")
      end

      it " > category has right subcategories" do
        get "/v1/categories/#{@category_1.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['subcategories'].length).to eq(1)
        expect(json['data']['attributes']['subcategories'][0]['attributes']['title']).to eq("subcat")
      end

      it "> subcategory has the right parent category" do
        get "/v1/categories/#{@category_2.id}"
        json = JSON.parse(response.body)

        expect(json['data']['attributes']['subcategories'].length).to eq(0)
        expect(json['data']['attributes']['parent-id'].to_i).to eq(@category_1.id)
      end
    end
  end

  context "displaying products for certain category" do
    # todo
  end

  context "find products using filters" do
    it "> finds product for given barcode" do
      product = FactoryGirl.create(:product, barcode: 555666)
      FactoryGirl.create_list(:product, 6)

      get "/v1/products?barcode=555666"

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['attributes']['barcode']).to eq(555666)

    end

    it "> finds products for given manufacturer" do
      manufacturer = FactoryGirl.create(:manufacturer)
      product = FactoryGirl.create(:product, manufacturer_id: manufacturer.id)
      FactoryGirl.create_list(:product, 3)

      get "/v1/products?manufacturer=#{manufacturer.id}"

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['attributes']['manufacturer']['id']).to eq(manufacturer.id)
    end

    it "> finds products for given label" do
      label = FactoryGirl.create(:label)
      product = FactoryGirl.create(:product, label_id: label.id)
      FactoryGirl.create_list(:product, 4)

      get "/v1/products?label=#{label.id}"

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['attributes']['label']['id']).to eq(label.id)
    end

    it "> finds products for given category" do
      category = FactoryGirl.create(:category)
      product = FactoryGirl.create(:product, category_id: category.id)
      FactoryGirl.create_list(:product, 3)

      get "/v1/products?category=#{category.id}"

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['attributes']['category']['id']).to eq(category.id)
    end

    it "> finds products for all three params given" do
      category = FactoryGirl.create(:category)
      label = FactoryGirl.create(:label)
      manufacturer = FactoryGirl.create(:manufacturer)

      product = FactoryGirl.create(:product, category_id: category.id, manufacturer_id: manufacturer.id, label_id: label.id)
      FactoryGirl.create(:product, category_id: category.id, manufacturer_id: manufacturer.id)
      FactoryGirl.create_list(:product, 2)
      get "/v1/products?category=#{category.id}&manufacturer=#{manufacturer.id}&label=#{label.id}"

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['attributes']['category']['id']).to eq(category.id)
    end

  end

end