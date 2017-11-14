require 'rails_helper'

RSpec.feature "Labels feature spec >", :type => :feature do

  before(:each) {
    login_as(FactoryBot.create(:user, superadmin: true), :scope => :user)
  }

  before(:each) do
    FactoryBot.create(:general_setting)
    # GeneralSetting.create(url: "something.com", language: { "ru" => "ru" }, address: "Москва, ул. 2ая Хуторская 38")
  end

  before(:each) do
    @main_label = FactoryBot.create(:label, title: "My main labelz")
    @label_1 = FactoryBot.create(:label, parent_id: @main_label.id, title: "Grizzly Bears Ltd.")
    @label_2 = FactoryBot.create(:label, parent_id: @main_label.id, title: "Shitty Dizzy")
    @label_3 = FactoryBot.create(:label, parent_id: @main_label.id, title: "Some Leftovers")
  end

  feature "crud methods" do
    scenario "> creating a sub-label from index page leads to correct new page (containing parent select field)" do
      visit admin_labels_path(sublevel: true)

      click_link('new_entry')

      expect(page).to have_css('#label_parent_id')
    end

    scenario "> sublevel index show only sublabels" do
      visit admin_labels_path(sublevel: true)
      # 4 саблейбла, потому что их 3 + заголовок таблицы как один ряд считается

      expect(page.all('table#listing_table tr').count).to eq(4)
    end

    scenario "> regular index show only labels" do
      FactoryBot.create(:label)
      visit admin_labels_path
      
      # 3 лейбла, потому что их 2 + заголовок таблицы как один ряд считается
      expect(page.all('table#listing_table tr').count).to eq(3)
      expect(page).not_to have_content("Grizzly Bears Ltd.")
      expect(page).to have_content("My main labelz")
    end
  end

  feature "bulk delete >" do
    scenario "delete level 2 labels" do
      visit admin_labels_path(sublevel: true)
      
      find(:css, "input[type=checkbox][value='#{@label_2.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{@label_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        }.to change(Label, :count).by(-2)
      # save_and_open_page
      expect(page).not_to have_content("Shitty Dizzy")
      expect(page).to have_content("Grizzly Bears Ltd.")
    end

    scenario "delete level 1 labels" do
      main_label_2 = FactoryBot.create(:label, title: "Bin Supraman")
      main_label_3 = FactoryBot.create(:label)
      visit admin_labels_path
      
      find(:css, "input[type=checkbox][value='#{@main_label.id}']").set(true)
      find(:css, "input[type=checkbox][value='#{main_label_3.id}']").set(true)

      expect { 
        find("#bulk-delete", visible: false).click
        # -5 потому что вместе с родительским лейблом удаляем ещё и 3 дочерних (итого 2 род. плюс 3 доч. - итого минус 5)
        }.to change(Label, :count).by(-5)
      # save_and_open_page
      expect(page).not_to have_content("My main labelz")
      expect(page).to have_content("Bin Supraman")
    end
  end
end