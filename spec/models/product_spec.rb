require 'rails_helper'

RSpec.describe Product, type: :model do
  it "does not save without category/subcategory" do
    product = FactoryGirl.build(:product, category: nil)
    # expect{
    #   product.save
    # }.not_to change(Product, :count).by(1)
    expect(product).not_to be_valid
  end

  it "does not save without a manufacturer/trademark" do
    product = FactoryGirl.build(:product, manufacturer: nil)
    expect(product).not_to be_valid
  end

  it "does not save without a kosher label" do
    product = FactoryGirl.build(:product, label: nil)
    expect(product).not_to be_valid
  end

  it "does not save without a title" do
    product = FactoryGirl.build(:product, title: nil)
    expect(product).not_to be_valid
  end

  context "barcodes" do
    it "saves a real barcode (big number)" do
      product = FactoryGirl.build(:product, barcode: 4605490000217)
      expect{
        product.save
        }.to change(Product, :count).by(1)
    end

    it "saves multiple barcodes" do
      product = FactoryGirl.build(:product)
      product.barcodes.build
      product.barcodes.build
      
      product.save
      expect(product.barcodes.count).to eq(2)
    end
  end
end
