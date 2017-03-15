require 'rails_helper'

RSpec.describe City, type: :model do
  let (:valid_city) { FactoryGirl.build(:city) }
  let (:city_no_images) { FactoryGirl.build(:city, front_image: nil, back_image: nil, name: "Something") }
  let (:city_nothing) { FactoryGirl.build(:city, front_image: nil, back_image: nil, name: nil) }

  it "has valid factory" do
    expect(valid_city).to be_valid
  end

  it "is unvalid without images" do
    expect(city_no_images).not_to be_valid
  end

  it "is unvalid with no data at all" do
    expect(city_nothing).not_to be_valid
  end

  it "saves city with valid params" do
    expect{
        valid_city.save 
        }.to change(City, :count).by(1)
  end

  it "does not save city with invalid params" do
    expect{
      city_nothing.save
    }.not_to change(City, :count)
  end
end
