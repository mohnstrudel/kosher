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
        click_button 'shared_form_submit_button'
        }.to change(Post, :count).by(1)
    end
  end

  feature "SEO parameters" do
    scenario "when creating new post" do
      visit admin_posts_path

      click_link('new_entry')

      fill_in 'post_title', with: "Happy Tree Friends"
      fill_in 'post_seo_attributes_title', with: "Mortymer"

      click_button 'shared_form_submit_button'
      
      expect(Post.last.seo.title).to eq('Mortymer')  

    end
  end

end