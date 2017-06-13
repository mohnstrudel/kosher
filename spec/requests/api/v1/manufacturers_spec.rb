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
      @product = FactoryGirl.create(:product, category_id: @category.id, manufacturer_id: @manufacturer.id)
    end
    
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
      expect(attrs.keys).to contain_exactly("description", 'logo', 'parent-id', 'title', 'categories')
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
  end
end