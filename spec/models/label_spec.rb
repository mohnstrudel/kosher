require 'rails_helper'

RSpec.describe Label, type: :model do
  
  let(:label) { FactoryBot.build(:label, id: 1) }
  let(:sublabel) { FactoryBot.build(:label, id: 2, parent_id: 1) }

  it "deletes child with parent" do
    label.save
    sublabel.save
    expect{
      label.destroy
    }.to change(Label, :count).by(-2)
  end
end
