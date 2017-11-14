require 'rails_helper'

describe "FAQs API" do
  context "displaying only faqs" do
    it "lists all faqs" do
      FactoryBot.create_list(:faq, 3)
      
      get '/v1/faqs'
      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(3)

    end

  end
end