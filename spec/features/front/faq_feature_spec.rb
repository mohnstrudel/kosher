require 'rails_helper'

RSpec.feature "FAQ front feature spec >", :type => :feature do

  before(:each) do
    FactoryBot.create(:general_setting)
  end

  feature "simple page operations" do
    scenario "successfull page opening" do
      visit '/faq'
      expect(page.status_code).to eq(200)
    end
  end

  feature 'viewing the questions' do
    scenario 'assert 2 faqs' do
      FactoryBot.create(:faq, answer: 'So long!', question: 'How come?')
      FactoryBot.create(:faq, question: 'How many fingers?', answer: 'Six were chopped off')

      visit '/faq'

      expect(find('ul.g-faq')).to have_selector('li', count: 2)
    end
  end
end