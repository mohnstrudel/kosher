require 'rails_helper'

describe 'Posts API' do

  context "displaying only posts" do

    it "lists all posts" do
      category = FactoryBot.create(:post_category)
      FactoryBot.create_list(:post, 6, post_category: category)

      get '/v1/posts'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(6)
    end

    it "shows a post" do
      post = FactoryBot.create(:post, post_category: FactoryBot.create(:post_category))

      get "/v1/posts/#{post.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(post.id)
    end

    it "shows specific values for a post" do
      post = FactoryBot.create(:post, post_category: FactoryBot.create(:post_category))

      get "/v1/posts/#{post.id}"

      json = JSON.parse(response.body)

      attrs = json['data']['attributes']
      expect(attrs['logo']['url']).not_to be nil
      expect(attrs['logo']['url']).to eq("/uploads/test/post/logo/#{post.id}/rails.jpg")
    end
  end

  context "displaying posts from current category" do
    before(:each) {
      @category = FactoryBot.create(:post_category)
    }

    it "lists all posts" do
      FactoryBot.create_list(:post, 7, post_category_id: @category.id)

      get "/v1/post_categories/#{@category.id}/posts"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data'].length.to_i).to eq(7)
    end

    it "shows a specific post" do
      post = FactoryBot.create(:post, post_category_id: @category.id)

      get "/v1/post_categories/#{@category.id}/posts/#{post.id}"
      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(post.id)
    end
  end
  
end