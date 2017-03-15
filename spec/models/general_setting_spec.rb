require 'rails_helper'

RSpec.describe GeneralSetting, type: :model do
  describe "saving phones" do
    let (:no_phones) { FactoryGirl.build(:general_setting, phones: []) }
    let (:no_opening_hours) { FactoryGirl.build(:general_setting, opening_hours: []) }
    let (:regular) { FactoryGirl.build(:general_setting) } 
    let (:invalid) { FactoryGirl.build(:general_setting, url: nil) } 

    it "is invalid with no url" do
      expect{
        invalid.save
      }.not_to change(GeneralSetting, :count)
    end
    
    it "saves a record without phones" do  
      expect{
        no_phones.save
      }.to change(GeneralSetting, :count).by(1)
    end

    it "saves three phones and returns them" do
      expect{
        regular.save
      }.to change(Phone, :count).by(3)
    end

    it "saves five opening hours and returns them" do
      expect{
        regular.save
      }.to change(OpeningHour, :count).by(5)
    end

    it "saves a record without opening hours" do
      expect{
        no_opening_hours.save
      }.to change(GeneralSetting, :count).by(1)
    end
  end
end
