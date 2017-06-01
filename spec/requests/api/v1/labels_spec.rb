require 'rails_helper'

describe 'Labels API' do
  context "displaying only labels" do
    it "lists all labels" do
      FactoryGirl.create_list(:label, 3)

      get '/v1/labels'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(3)
    end

    it "shows a label" do
      label = FactoryGirl.create(:label)

      get "/v1/labels/#{label.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(label.id)
    end
  end
  
end