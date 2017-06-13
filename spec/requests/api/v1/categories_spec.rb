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
      @product = FactoryGirl.create(:product, category_id: @category.id, manufacturer_id: @manufacturer.id)
      @subcategory = FactoryGirl.create(:category, parent_id: @category.id)
    end
    it "shows a list of labels belonging to this particular category" do
      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)
      attrs = json['data']['attributes']
      expect(attrs.keys).to contain_exactly("description","logo", "parent-id", "title", "labels", "label-id", "manufacturers", "subcategories")
    end

    it "shows the correct fields for a label" do
      label = FactoryGirl.create(:label, title: "Bash Azam")

      product = FactoryGirl.create(:product, label_id: label.id, category_id: @category.id)

      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)
      attrs = json['data']['attributes']
      expect(attrs['labels'].length).to eq(1)
      expect(attrs['labels'][0]['title']).to eq("Bash Azam")
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
      product_2 = FactoryGirl.create(:product, category_id: @category.id, manufacturer_id: @manufacturer.id)

      get "/v1/categories/#{@category.id}"

      json = JSON.parse(response.body)

      expect(json['data']['attributes']['manufacturers'].length).to eq(1)
    end
  end
end