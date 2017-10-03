require 'rails_helper'

describe "Categories API" do
  context "on index page" do
    it "shows a list of labels belonging to each category" do
      # todo? По-моему вообще не нужно показывать тут, на всякий случай
      # плейсхолдер под тест оставим
    end
  end

  context "on show page" do
    before(:each) do
      @category = FactoryGirl.create(:category)
      @manufacturer = FactoryGirl.create(:manufacturer) 
      @subcategory = FactoryGirl.create(:category, parent_id: @category.id)
      @product = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id)
    end
    it "shows a list of labels belonging to this particular category" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)
      attrs = json['data']['attributes']
      expect(attrs.keys).to contain_exactly("description","logo", "parent-id", "title", "labels", "label-id", "manufacturers", "subcategories")
    end

    it "shows the correct fields for a label" do
      label = FactoryGirl.create(:label, title: "Bash Azam")

      product_2 = FactoryGirl.create(:product, label_id: label.id, category_id: @subcategory.id)
      # Так как мы создаем выше ещё один продукт, то лейблов будет два

      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)
      attrs = json['data']['attributes']
      expect(attrs['labels'].length).to eq(2)
      
      expect(attrs['labels']).to include(include("title" => "Bash Azam"))
    end

    it "has iOS appropriate manufacturers structure" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      manufacturer = json['data']['attributes']['manufacturers'][0]
      expect(manufacturer.keys).to contain_exactly("id", 'type', 'parent-id', 'attributes')
    end

    it "has iOS appropriate manufacturer attributes" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      # puts "JSON response: #{json.inspect}"
      attrs = json['data']['attributes']['manufacturers'][0]['attributes']
      expect(attrs.keys).to contain_exactly("title", 'description', 'logo')
    end

    it "has iOS appropriate subcategories structure" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      subcategory = json['data']['attributes']['subcategories'][0]
      expect(subcategory.keys).to contain_exactly('id', 'attributes')
    end

    it "has iOS appropriate subcategories attributes" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      attrs = json['data']['attributes']['subcategories'][0]['attributes']
      expect(attrs.keys).to contain_exactly("title", 'description', 'logo')
    end

    it "has no duplicate categories" do
      product_2 = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id)

      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      expect(json['data']['attributes']['manufacturers'].length).to eq(1)
    end

    it "has manufacturers while being a parent category" do
      # Создаем продукт, который привязан к производителю и к ПОДкатегории
      product_2 = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id)
      # На странице родительской категории производитель должен быть виден
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      expect(json['data']['attributes']['manufacturers'].length).to eq(1)
    end

    describe "testing for duplicate labels" do

      before(:each) do
        label = FactoryGirl.create(:label)
        product_2 = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id, label: label)
        product_3 = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id, label: FactoryGirl.create(:label))
        product_4 = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id, label: label)
      end

      it "as parent" do
        # При создании продукта (выше) автоматом создается лейбл. Соответственно итого у нас 4 лейбла, но 2 из них 
        # одинаковые. Поэтому тестим на 3
        get "/v1/categories/#{@category.id}"

        json = JSON.parse(response.body)

        expect(json['data']['attributes']['labels'].length).to eq(3)
      end

      it "as child" do
        product = FactoryGirl.create(:product, category_id: @subcategory.id, manufacturer_id: @manufacturer.id, label: FactoryGirl.create(:label))
        get "/v1/categories/#{@subcategory.id}"

        json = JSON.parse(response.body)

        expect(json['data']['attributes']['labels'].length).to eq(4)
      end
    end
  end
end