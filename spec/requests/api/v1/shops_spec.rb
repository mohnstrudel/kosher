require 'rails_helper'

describe "Shops API" do
  it 'lists a list of shops' do
    FactoryGirl.create_list(:shop, 10)

    get '/v1/shops'

    json = JSON.parse(response.body)

    # test for the 200 status-code
    expect(response).to be_success

    # check to make sure the right amount of shops are returned
    expect(json['data'].length).to eq(10)
  end

  it 'shows the shop page' do
    shop = FactoryGirl.create(:shop)

    get "/v1/shops/#{shop.id}"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json['data']['id']).to eq("1")
  end
end