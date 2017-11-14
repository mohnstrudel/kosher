require 'rails_helper'

RSpec.describe Shop, type: :model do
	let (:regular) { FactoryBot.build(:shop) } 
  let (:created) { FactoryBot.create(:shop) }
  let (:invalid) { FactoryBot.build(:shop, title: nil) }
  
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

  describe "SEO parameters" do
    it "saves them when creating new shop" do
      shop = FactoryBot.build(:shop)
      shop.build_seo
      shop.seo.title = "My SEO title"
      shop.seo.keywords = ["hello", "dolly"]

      shop.save

      expect(shop.seo.title).to eq("My SEO title")
      expect(shop.seo.keywords).to eq(["hello", "dolly"])
    end

    it "saves them when editing shop" do
      shop = FactoryBot.create(:shop)

      shop.update(seo_attributes: {title: "Some other title", keywords: ["tag 1", "tag 2"]})

      expect(shop.seo.title).to eq("Some other title")
      expect(shop.seo.keywords).to eq(["tag 1", "tag 2"])
    end
  end
end
