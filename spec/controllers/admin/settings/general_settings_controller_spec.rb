require 'rails_helper'

RSpec.describe Admin::Settings::GeneralSettingsController, type: :controller do

  # let(:action) { post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) } }

  context 'POST methods' do
    describe 'post create' do
      it "saves the record with valid attributes" do
        # expect{
        #   post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) }
        #   }.to change{GeneralSetting.count}.by(1)
      end
    end
  end
end
