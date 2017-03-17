require 'rails_helper'
require 'pry'

RSpec.describe Admin::Settings::GeneralSettingsController, type: :controller do
  before(:each) do
    @already_created = FactoryGirl.create(:general_setting, language: {"ru" => "ru", "en" => "en"})
  end

  before(:each) do
    allow(subject).to receive(:find_hooker)
  end
  login_superadmin
  # let(:action) { post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) } }

  context 'POST methods' do
    describe 'post create' do
      it "saves the record with valid attributes" do
        # expect{
        #   post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) }
        #   }.to change{GeneralSetting.count}.by(1)

        expect{
          post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) }
          # binding.pry
        }.to change(GeneralSetting, :count).by(1)
      end

      it 'responds with HTTP 200' do
        post :create, params: { general_setting: FactoryGirl.attributes_for(:general_setting) }
        # expect(response).to have_http_status(:success)
        expect(response).to have_http_status(302)
      end

      it 'calls :find_hooker' do
        # expect(subject).to have_received(:find_hooker)
      end
    end
  end
end
