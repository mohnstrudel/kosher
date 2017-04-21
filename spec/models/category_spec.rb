require 'rails_helper'

RSpec.describe Category, type: :model do
  let (:valid_cat) { FactoryGirl.build(:category) }
  let (:level_two) { FactoryGirl.build(:category, id: 2, parent_id: 1) }
  let (:invalid_cat) { FactoryGirl.build(:category, title: nil) }

  it "has valid factory" do
    expect(valid_cat).to be_valid
  end

  it "has invalid factory" do
    expect(invalid_cat).not_to be_valid
  end

  it "saves a category with valid params" do
    expect{
      valid_cat.save
    }.to change(Category, :count).by(1)
  end

  it "does not save a category with invalid params" do
    expect{
      invalid_cat.save
    }.not_to change(Category, :count)
  end

  it "does not include subcategory within categories" do
    valid_cat.save
    @subcat = FactoryGirl.create(:category, id: 2, parent_id: 1)
    # @user = Factory(:user, :active => false)
    expect(Category.top_level).not_to include(@subcat)
  end

  it "does not include category within subcategories" do
    @cat = FactoryGirl.create(:category)
    level_two.save

    expect(Category.subs).not_to include(@cat)
  end

  it "does include subcategory within subs scope" do
    level_two.save
    expect(Category.subs).to include(level_two)
  end

  it "does include category within top_level scope" do
    valid_cat.save
    expect(Category.top_level).to include(valid_cat)
  end
end
