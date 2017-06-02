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
        @product = FactoryGirl.create(:product, title: "Rspec Product", description: "Rspec description")
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

        expect(json['data']['attributes']['manufacturer']).to eq(nil)
        expect(json['data']['attributes']['category']).to eq(nil)
        expect(json['data']['attributes']['label']).to eq(nil)
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
        expect(json['data']['attributes']['subcategories'][0]['title']).to eq("subcat")
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
      # todo
    end

    it "> finds products for given manufacturer" do
      # todo
    end

    it "> finds products for given label" do
      # todo
    end

    it "> finds products for given category" do
      # todo
    end

  end

end