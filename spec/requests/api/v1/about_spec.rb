require 'rails_helper'

describe "About API" do
  context "displaying about page" do
    it "shows the page" do
      get '/v1/about'

      expect(response).to be_success
    end

    it "shows correct mail info" do
      FactoryGirl.create(:general_setting, email: "testmail@test.com")

      get '/v1/about'

      json = JSON.parse(response.body)

      expect(json['data']['attributes']['email']).to eq("testmail@test.com")
    end

    it "shows correct opening hours info" do
      FactoryGirl.create(:general_setting)

      get '/v1/about'

      json = JSON.parse(response.body)
      attribs = json['data']['attributes']
      
      expect(attribs['opening-hours'].length).to eq(5)  
    end

    it "shows correct phones info" do
      FactoryGirl.create(:general_setting)

      get '/v1/about'

      json = JSON.parse(response.body)
      attribs = json['data']['attributes']
      
      expect(attribs['phones'].length).to eq(3)  
    end
  end
end