require 'rails_helper'

describe "Restaurants API" do
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

  context "displaying restaurants from current city" do
    before(:each) {
      @city = FactoryBot.create(:city)
    }

    it "lists all restaurants" do
      FactoryBot.create_list(:restaurant, 10, city_id: @city.id)

      get "/v1/cities/#{@city.id}/restaurants"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length.to_i).to eq(10)
    end

    it "shows a restaurant" do
      restaurant = FactoryBot.create(:restaurant, city_id: @city.id)

      get "/v1/cities/#{@city.id}/restaurants/#{restaurant.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(restaurant.id)
    end
  end
end