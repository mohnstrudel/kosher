require 'rails_helper'

describe "Manufacturers API" do

  context "lists all manufacturers" do
    it "has only whitelisted attributes" do
      get '/v1/manufacturers'

      json = JSON.parse(response.body)

      expect(response).to be_success
      json['data'].each do |child|
        attrs = child['attributes']
        expect(attrs.keys).to contain_exactly("description","logo", "parent-id", "title")
      end
    end

    it "has no categories" do
      get '/v1/manufacturers'

      json = JSON.parse(response.body)

      json['data'].each do |child|
        attrs = child['attributes']
        expect(attrs.keys).not_to contain_exactly("description","logo", "parent-id", "title", "categories")
      end
    end

    it "has proper amount of list items" do
      FactoryGirl.create_list(:manufacturer, 5)

      get '/v1/manufacturers'

      json = JSON.parse(response.body)

      expect(json['data'].length).to eq(5)
    end
  end

  context "shows a manufacturer" do
    before(:each) do
      @category = FactoryGirl.create(:category)
      @manufacturer = FactoryGirl.create(:manufacturer)
      @trademark = FactoryGirl.create(:manufacturer, parent_id: @manufacturer.id)
      @product = FactoryGirl.create(:product, category: @category, manufacturer: @trademark)
    end

    describe "parent object" do
    
      it "has proper id" do
        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        expect(json['data']['id'].to_i).to eq(@manufacturer.id)
      end

      it "has categories listed" do
        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        expect(json['data']['attributes']['categories'].length).to eq(1)
        expect(json['data']['attributes']['categories'][0]['id'].to_i).to eq(@category.id)
      end

      it "has only the whitelisted attributes" do
        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        attrs = json['data']['attributes']
        # Labels добавили 03/10/2017В
        expect(attrs.keys).to contain_exactly("description", 'logo', 'parent-id', 'title', 'categories', 'labels')
      end

      it "has iOS appropriate categories structure" do
        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        categories = json['data']['attributes']['categories'][0]
        expect(categories.keys).to contain_exactly("id", 'type', 'attributes')
      end

      it "has iOS appropriate category attributes" do
        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        attrs = json['data']['attributes']['categories'][0]['attributes']
        expect(attrs.keys).to contain_exactly("title", 'description', 'logo','parent-id', 'label-id')
      end

      it "has no duplicate categories" do
        product_2 = FactoryGirl.create(:product, category_id: @category.id, manufacturer_id: @manufacturer.id)

        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        expect(json['data']['attributes']['categories'].length).to eq(1)
      end

      it "has all categories from its children" do
        trademark_2 = FactoryGirl.create(:manufacturer, parent_id: @manufacturer.id)
        product_2 = FactoryGirl.create(:product, category: FactoryGirl.create(:category), manufacturer_id: @trademark.id)
        product_3 = FactoryGirl.create(:product, category: FactoryGirl.create(:category), manufacturer_id: trademark_2.id)

        get "/v1/manufacturers/#{@manufacturer.id}"

        json = JSON.parse(response.body)

        # один продукт связывает сверху и два мы сейчас создали, итого должно быть 3
        expect(json['data']['attributes']['categories'].length).to eq(3)
      end
    end

    describe "child object" do
      it "has its own category" do
        trademark_2 = FactoryGirl.create(:manufacturer, parent_id: @manufacturer.id)
        product_2 = FactoryGirl.create(:product, category: FactoryGirl.create(:category), manufacturer_id: trademark_2.id)

        get "/v1/manufacturers/#{trademark_2.id}"

        json = JSON.parse(response.body)

        # итого у родителя 2 категории, но мы в гостях у ребенка, там должна быть только одна категория
        expect(json['data']['attributes']['categories'].length).to eq(1)
      end
    end

  context "labels" do
    describe "parent object" do
      it "has unique labels from its trademarks" do
        manufacturer = FactoryGirl.create(:manufacturer)
        trademark_1 = FactoryGirl.create(:manufacturer, parent_id: manufacturer.id)
        trademark_2 = FactoryGirl.create(:manufacturer, parent_id: manufacturer.id)

        label = FactoryGirl.create(:label)
        product_1 = FactoryGirl.create(:product, manufacturer: trademark_1, label: label)
        product_2 = FactoryGirl.create(:product, manufacturer: trademark_1)
        product_3 = FactoryGirl.create(:product, manufacturer: trademark_2)
        product_4 = FactoryGirl.create(:product, manufacturer: trademark_2, label: label)
        # Итого у нас 4 продукта, но только 3 уникальных лейбла

        get "/v1/manufacturers/#{manufacturer.id}"
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['labels'].length).to eq(3)
      end
    end

    describe "child object" do
      it "has labels" do
        manufacturer = FactoryGirl.create(:manufacturer)
        trademark = FactoryGirl.create(:manufacturer, parent_id: manufacturer.id)

        product_1 = FactoryGirl.create(:product, manufacturer: trademark)
        product_2 = FactoryGirl.create(:product, manufacturer: trademark)

        get "/v1/manufacturers/#{trademark.id}"
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['labels'].length).to eq(2)
      end
    end
  end


  end
end