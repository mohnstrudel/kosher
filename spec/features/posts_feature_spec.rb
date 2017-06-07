require 'rails_helper'

RSpec.feature "Posts feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryGirl.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryGirl.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  feature "crud methods" do

    scenario "> create" do
      visit admin_posts_path

      click_link('new_entry')
      
      fill_in 'post_title', with: "Grizzly Bears Ltd."
      
      expect { 
        within find('#tab-2') do
          find("input[type='submit']").click 
        end
        }.to change(Post, :count).by(1)
    end
  end

end