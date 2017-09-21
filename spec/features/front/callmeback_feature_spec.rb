require 'rails_helper'

RSpec.feature "Call Me Back contact front feature spec >", :type => :feature, js: true do
  
  before(:each) do
    FactoryGirl.create(:general_setting)
  end

  feature "invalid form" do
    scenario "with only name" do
      visit '/'
      # save_and_open_page
      execute_script '$("#call-popup").fadeIn(300)'

      fill_in 'call_me_back_request_name', with: 'Clark'

      within '#new_call_me_back_request' do
        expect{
          find("input[type='submit']").click
          wait_for_ajax
        }.not_to change(Request, :count)
      end
    end

    scenario "with only phone" do
      visit '/'
      # save_and_open_page
      execute_script '$("#call-popup").fadeIn(300)'

      fill_in 'call_me_back_request_phone', with: '1234445566'

      within '#new_call_me_back_request' do
        expect{
          find("input[type='submit']").click
          wait_for_ajax
        }.not_to change(Request, :count)
      end
    end
  end

  feature 'valid form' do
    scenario "with name and phone" do
      visit '/'
      execute_script '$("#call-popup").fadeIn(300)'

      fill_in 'call_me_back_request_name', with: 'Clark'
      fill_in 'call_me_back_request_phone', with: '1234445566'

      within '#new_call_me_back_request' do
        expect{
          find("input[type='submit']").click
          sleep(inspection_time=1)
          wait_for_ajax
        }.to change(Request, :count).by(1)
      end
    end

    scenario 'data persistance' do
      visit '/'
      execute_script '$("#call-popup").fadeIn(300)'

      fill_in 'call_me_back_request_name', with: 'Clark'
      fill_in 'call_me_back_request_phone', with: '1234445566'

      within '#new_call_me_back_request' do
        find("input[type='submit']").click
        wait_for_ajax
      end
      
      request = Request.last

      expect(request.name).to eq('Clark')
      expect(request.phone).to eq('+7 (123) 444-55-66')
      expect(request.type).to eq('CallMeBackRequest')
    end

  end
end

