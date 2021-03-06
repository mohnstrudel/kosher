require 'rails_helper'

describe "Shops API" do
  context "listing shops" do
    it 'checks the proper amount on index page' do
      FactoryBot.create_list(:shop, 10)

      get '/v1/shops'

      json = JSON.parse(response.body)

      # test for the 200 status-code
      expect(response).to be_success

      # check to make sure the right amount of shops are returned
      expect(json['data'].length).to eq(10)
    end


  end
  context "detailed page" do
    it 'shows the shop page' do
      shop = FactoryBot.create(:shop)

      get "/v1/shops/#{shop.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      
      expect(json['data']['id'].to_i).to eq(shop.id)
    end
  end
end