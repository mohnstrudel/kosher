require 'rails_helper'

describe "Cities API" do
  context "displaying only cities" do
    it "lists all cities" do
      FactoryBot.create_list(:city, 10)
      
      get '/v1/cities'
      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(10)

    end
    it "shows a city" do
      city = FactoryBot.create(:city)

      get "/v1/cities/#{city.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(city.id)
    end
  end

  context "displaying shops from current city" do
    before(:each) {
      @city = FactoryBot.create(:city)
    }

    it "lists all shops" do
      FactoryBot.create_list(:shop, 10, city_id: @city.id)

      get "/v1/cities/#{@city.id}/shops"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length.to_i).to eq(10)
    end

    it "shows a shop" do
      shop = FactoryBot.create(:shop, city_id: @city.id)

      get "/v1/cities/#{@city.id}/shops/#{shop.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(shop.id)
    end
  end
end