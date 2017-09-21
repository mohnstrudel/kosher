require 'rails_helper'

RSpec.feature "Subscriber front feature spec >", :type => :feature, js: true do
  before(:each) do
    FactoryGirl.create(:general_setting)
  end

  feature 'invalid form' do
    scenario "with no email" do
      visit root_path
      visit '#footer'
      expect{
        click_button 'subscriber_form_submit'
        wait_for_ajax
      }.not_to change(Subscriber, :count)
    end

    scenario "with invalid email" do
      visit root_path
      visit '#footer'
      fill_in 'subscriber_email', with: 'clark@kent'


      expect{
        click_button 'subscriber_form_submit'
        wait_for_ajax
      }.not_to change(Subscriber, :count)
    end
  end

  scenario "valid form" do
    visit root_path
    visit '#footer'
    
    Subscriber.destroy_all

    fill_in 'subscriber_email', with: 'clark@kent.com'
    # sleep(inspection_time=5)
    # old_subs = Subscriber.all.count
    
    expect{
      click_button 'subscriber_form_submit'
      sleep(inspection_time=1)
      # wait_for_ajax
      }.to change(Subscriber, :count).by(1)

  end
end
  