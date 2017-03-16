require 'rails_helper'

RSpec.describe Shop, type: :model do
	let (:regular) { FactoryGirl.build(:shop) } 
  let (:created) { FactoryGirl.create(:shop) }
  let (:invalid) { FactoryGirl.build(:shop, title: nil) }
  
  context "saving phones" do
  	it "saves 6 phones" do
      expect{
        regular.save
      }.to change(Phone, :count).by(6)
  	end

    it "has 6 phones" do
      regular.save
      expect(regular.phones.length).to eq(6)
    end

    it "has 4 opening hours" do
      expect{
        regular.save
      }.to change(OpeningHour, :count).by(4)
    end
  end

  context "testing validations" do
    it "is not valid without title" do
      expect(invalid).not_to be_valid
    end

    it "does not save without title" do
      expect{
        invalid.save
      }.not_to change(Shop, :count)
    end
  end
end
