require 'rails_helper'

describe "Subscribers API" do
  context "valid subscriber" do
    it 'has a successfull response' do
      # post '/v1/subscribers', :subscriber => {:email => "johnhippedydoe@gmail.com"}
      post '/v1/subscribers',  params: { subscriber: { email: Faker::Internet.email }}
      json = JSON.parse(response.body)
      # test for the 200 status-code
      expect(response).to be_success
    end

    it 'creates a new record' do
      expect{
        post '/v1/subscribers',  params: { subscriber: { email: Faker::Internet.email }}
        }.to change(Subscriber, :count).by(1)
    end
  end

  context "invalid subscriber" do

    it "has empty email" do
      expect{
        post '/v1/subscribers', params: { subscriber: {email: ""} }
        }.not_to change(Subscriber, :count)
      expect(response.status).to eq(422)
    end

    it "has invalid email" do
      expect{
        post '/v1/subscribers', params: { subscriber: {email: "johndoe@asd"}}  
      }.not_to change(Subscriber, :count)
      expect(response.status).to eq(422)
    end

  end
end