require 'rails_helper'

describe 'Posts API' do
  context "displaying only posts" do
    it "lists all posts" do
      FactoryGirl.create_list(:post, 6)

      get '/v1/posts'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(6)
    end

    it "shows a post" do
      post = FactoryGirl.create(:post)

      get "/v1/posts/#{post.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(post.id)
    end
  end

  context "displaying posts from current category" do
    before(:each) {
      @category = FactoryGirl.create(:post_category)
    }

    it "lists all posts" do
      FactoryGirl.create_list(:post, 7, post_category_id: @category.id)

      get "/v1/post_categories/#{@category.id}/posts"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length.to_i).to eq(7)
    end

    it "shows a specific post" do
      post = FactoryGirl.create(:post, post_category_id: @category.id)

      get "/v1/post_categories/#{@category.id}/posts/#{post.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(post.id)
    end
  end
  
end