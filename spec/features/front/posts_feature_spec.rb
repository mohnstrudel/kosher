require 'rails_helper'

RSpec.feature "Front posts feature spec >", :type => :feature do
  
  before(:each) do
    FactoryBot.create(:general_setting)
  end

  before(:each) do
    @page_size = Rails.application.config.page_size
  end

  feature "index page" do

    scenario "> should have 5 elements" do
      # puts "Post count before is: #{Post.count}"
      result = FactoryBot.create_list(:post, 5)
      visit posts_path
      # puts "Post count after is: #{Post.count}"
      # puts "Factory result is: #{result.inspect}"
      # save_and_open_page

      if @page_size > 5

        expect(find('ul.g-news')).to have_selector('li', count: 5)
      else
        expect(find('ul.g-news')).to have_selector('li', count: @page_size)
      end
    end

    scenario "> pagination with a lot of posts" do
      FactoryBot.create_list(:post, @page_size+2)

      visit posts_path
      expect(page).to have_css "a[href~='/news?page=2']"
    end

    scenario "> pagination with few posts" do
      FactoryBot.create_list(:post, @page_size-2)

      visit posts_path
      
      # Если айтемов меньше, чем @page_size, то пагинацию мы не показываем!
      expect(page).not_to have_css(".g-pagination__item")
      # expect(page).not_to have_css "a[href~='/news?page=2']"
    end

    scenario "> should have appropriate content" do
      FactoryBot.create(:post, title: "Супер")
      FactoryBot.create(:post, body: "Some creative badass news")

      visit posts_path
      # save_and_open_page

      expect(find('ul.g-news')).to have_selector('li', count: 2)
      expect(page).to have_content('Some creative badass news')
      expect(page).to have_css "a[href~='/news/super']"
      # expect(find_link('Подробнее')[:href]).to eq('/news/super')
      # expect(page).to have_selector(:link_or_button, '/news/super')

    end
  end

  feature "show page" do
    scenario "> should have appropriate content" do
      post = FactoryBot.create(:post, title: "В бобруйске все спокойно")

      visit posts_path

      find(:xpath, "//a[@href='/news/#{post.slug}']").click
      
      expect(page).to have_content("В бобруйске все спокойно")
    end
  end

end