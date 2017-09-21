require 'rails_helper'

RSpec.feature "Contact front feature spec >", :type => :feature do
  
  before(:each) do
    FactoryGirl.create(:general_setting)
  end

  feature "simple page operations" do
    scenario "successfull page opening" do
      visit '/contact'
      expect(page.status_code).to eq(200)
    end
  end

  feature "sending invalid contact form" do
    scenario "fill in only name" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'

      expect{
        click_button 'contact_form_submit'
      }.not_to change(Request, :count)
    end

    scenario "fill in only name and company name" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'
      fill_in 'contact_request_company_name', with: 'Superpowers Ltd.'

      expect{
        click_button 'contact_form_submit'
      }.not_to change(Request, :count)
    end

    scenario "fill in only name, company name and phone" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'
      fill_in 'contact_request_company_name', with: 'Superpowers Ltd.'
      fill_in 'contact_request_phone', with: '123312123'

      expect{
        click_button 'contact_form_submit'
      }.not_to change(Request, :count)
    end

    scenario "fill in only name, company name, phone and invalid email" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'
      fill_in 'contact_request_company_name', with: 'Superpowers Ltd.'
      fill_in 'contact_request_phone', with: '123312123'
      fill_in 'contact_request_email', with: 'clark@kent'

      expect{
        click_button 'contact_form_submit'
      }.not_to change(Request, :count)
    end    
  end

  feature "sending valid contact form" do

    scenario "fill in name, company name, phone and valid email" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'
      fill_in 'contact_request_company_name', with: 'Superpowers Ltd.'
      fill_in 'contact_request_phone', with: '123312123'
      fill_in 'contact_request_email', with: 'clark@kent.com'

      expect{
        click_button 'contact_form_submit'
      }.to change(Request, :count).by(1)
    end 

    scenario "check correct data submission" do
      visit '/contact'
      fill_in 'contact_request_name', with: 'Clark Kent'
      fill_in 'contact_request_company_name', with: 'Superpowers Ltd.'
      fill_in 'contact_request_phone', with: '123312123'
      fill_in 'contact_request_email', with: 'clark@kent.com'

      click_button 'contact_form_submit'

      request = Request.last

      expect(request.name).to eq('Clark Kent')
      expect(request.email).to eq('clark@kent.com')
      expect(request.type).to eq('ContactRequest')
    end

  end

  feature "other contact information" do
    scenario "get address, phones and email" do
      GeneralSetting.destroy_all
      setting = FactoryGirl.create(:general_setting, address: "Kryptonite planet 3", email: 'hello@dolly.com')
      phone_1 = FactoryGirl.create(:phone, value: "555332266", general_setting_id: setting.id)
      phone_2 = FactoryGirl.create(:phone, value: "999332211", general_setting_id: setting.id)

      visit '/contact'
      # save_and_open_page

      expect(page).to have_content('Kryptonite planet 3')
      expect(page).to have_content('hello@dolly.com')
      expect(page).to have_content('555332266')
      expect(page).to have_content('999332211')
    end

    scenario 'get opening hours' do
      GeneralSetting.destroy_all
      setting = FactoryGirl.create(:general_setting)
      hour_1 = FactoryGirl.create(:opening_hour, title: 'ponedelnik', value: "10:41-12:95", general_setting_id: setting.id)
      hour_2 = FactoryGirl.create(:opening_hour, title: 'vtornik', value: "10:15-19:37", general_setting_id: setting.id)

      visit '/contact'

      expect(page).to have_content('ponedelnik')
      expect(page).to have_content('vtornik')
      expect(page).to have_content('10:41-12:95')
      expect(page).to have_content('10:15-19:37')
    end
  end
end 