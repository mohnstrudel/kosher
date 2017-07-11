require 'rails_helper'

RSpec.feature "Subscriber front feature spec >", :type => :feature, js: true do

  feature 'invalid form' do
    scenario "with no email" do
      visit root_path

      expect{
        click_button 'subscriber_form_submit'
        wait_for_ajax
      }.not_to change(Subscriber, :count)
    end

    scenario "with invalid email" do
      visit root_path

      fill_in 'subscriber_email', with: 'clark@kent'


      expect{
        click_button 'subscriber_form_submit'
        wait_for_ajax
      }.not_to change(Subscriber, :count)
    end
  end

  scenario "valid form" do
    visit root_path

    fill_in 'subscriber_email', with: 'clark@kent.com'

    old_subs = Subscriber.all.count
    
    expect{
      click_button 'subscriber_form_submit'
      wait_for_ajax
      }.to change(Subscriber, :count).by(1)

  end
end
  