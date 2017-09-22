require 'rails_helper'

describe 'Posts API' do

  context "displaying only posts" do
    it "should not work without a post category" do
      FactoryGirl.create_list(:post, 2)
      
      # expect(get '/v1/posts').not_to be_success
      expect {
        get '/v1/posts'
        }.to raise_error(NoMethodError)
    end

    it "lists all posts" do
      category = FactoryGirl.create(:post_category)
      FactoryGirl.create_list(:post, 6, post_category: category)

      get '/v1/posts'

      json = JSON.parse(response.body)
      
      # Ожидаем 200 ответ - успех
      expect(response).to be_success

      # Ожидаем нужно кол-во записей
      expect(json['data'].length).to eq(6)
    end

    it "shows a post" do
      post = FactoryGirl.create(:post, post_category: FactoryGirl.create(:post_category))

      get "/v1/posts/#{post.id}"

      json = JSON.parse(response.body)

      expect(response).to be_success
      expect(json['data']['id'].to_i).to eq(post.id)
    end

    it "shows specific values for a post" do
      post = FactoryGirl.create(:post, post_category: FactoryGirl.create(:post_category))

      get "/v1/posts/#{post.id}"

      json = JSON.parse(response.body)

      attrs = json['data']['attributes']
      expect(attrs['logo']['url']).not_to be nil
      expect(attrs['logo']['url']).to eq("/uploads/test/post/logo/#{post.id}/rails.jpg")
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