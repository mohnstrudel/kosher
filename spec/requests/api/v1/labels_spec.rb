require 'rails_helper'

describe 'Labels API' do
  context "index page" do
    it "lists all labels" do
      FactoryGirl.create_list(:label, 3)

      get '/v1/labels'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(3)
    end

    it "checks for attributes on right places" do
      label_1 = FactoryGirl.create(:label)
      # label_2 = FactoryGirl.create(:label, parent_id: label_1.id)

      get '/v1/labels'

      json = JSON.parse(response.body)

      attrs = json['data'][0]['attributes']

      expect(attrs.keys).to contain_exactly("title", 'description', 'logo', 'sublabels')
    end

    it "has empty sublabel if none was created" do
      label_1 = FactoryGirl.create(:label)
      get '/v1/labels'

      json = JSON.parse(response.body)

      subs = json['data'][0]['attributes']['sublabels']

      expect(subs).to be_empty
    end

    it "checks for attribute values" do
      label_1 = FactoryGirl.create(:label)
      label_2 = FactoryGirl.create(:label, parent_id: label_1.id)

      get '/v1/labels'

      json = JSON.parse(response.body)

      attrs = json['data'][0]['attributes']

      expect(attrs['title']).to eq(label_1.title)
      expect(attrs['sublabels'][0]['attributes']['title']).to eq(label_2.title)
    end
  end

  context "show page" do

    before(:each) do
      @label = FactoryGirl.create(:label)
    end

    it "shows a label" do
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(@label.id)
    end

    it "checks for attribute keys" do
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)

      attrs = json['data']['attributes']

      expect(attrs.keys).to contain_exactly('title', 'logo', 'description', 'sublabels', 'products')
    end

    it "checks for empty products" do
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)

      products = json['data']['attributes']['products']
      expect(products).to be_empty
    end

    it "checks for present products" do
      product = FactoryGirl.create(:product, label: @label)
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)
      products = json['data']['attributes']['products']
      expect(products).not_to be_empty
      expect(products.length).to eq(1)
      expect(products[0]['title']).to eq(product.title)
    end

    it "checks for empty sublabels" do
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)

      subs = json['data']['attributes']['sublabels']
      expect(subs).to be_empty
    end

    it "checks for present sublabels" do
      label = FactoryGirl.create(:label, parent_id: @label.id)
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)
      subs = json['data']['attributes']['sublabels']
      expect(subs).not_to be_empty
      expect(subs.length).to eq(1)
      expect(subs[0]['attributes']['title']).to eq(label.title)
    end

    it "checks for attribute values" do
      get "/v1/labels/#{@label.id}"
      json = JSON.parse(response.body)
      attrs = json['data']['attributes']
      
      expect(attrs['title']).to eq(@label.title)
    end

    it "checks for present sublabels attribute values" do
      label = FactoryGirl.create(:label, parent_id: @label.id)
      get "/v1/labels/#{@label.id}"

      json = JSON.parse(response.body)
      subs_attrs = json['data']['attributes']['sublabels'][0]['attributes']
      expect(subs_attrs['title']).to eq(label.title)
    end
  end
  
end