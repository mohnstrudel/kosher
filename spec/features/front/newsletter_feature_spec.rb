require 'rails_helper'

RSpec.feature "Newsletter feature spec >", :type => :feature, js: true do
  
  before(:each) do
    FactoryGirl.create(:general_setting)
  end

  before(:each) do
    # Delayed::Worker.delay_jobs = false
    @page_size = Rails.application.config.page_size
  end

  feature "subscribers" do
    scenario "add subscriber via front" do
      # Setup
      # visit root_path
      # fill_in 'subscriber_email', with: 'a.kostin.16@gmail.com'
      # click_button 'subscriber_form_submit'
      # wait_for_ajax
      
      # puts "Mailchimp list id: #{Figaro.env.mailchimp_list_id}"
      
      # Mailchimp checks
      # email = Digest::MD5.hexdigest("a.kostin.16@gmail.com")
      # response = Gibbon::Request.lists(Figaro.env.mailchimp_list_id).members(email).retrieve.body[:members]
      # expect(response.length).to be(1)

      # Clean up
      # Gibbon::Request.lists(Figaro.env.mailchimp_list_id).members(email).delete
    end
  end

end