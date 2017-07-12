require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creating new post" do
    it "succeeds" do
      post = FactoryGirl.build(:post)
      expect{
        post.save
        }.to change(Post, :count).by 1
    end

    it "has the logo" do
      post = FactoryGirl.build(:post)
      post.save

      expect(post.logo.url).to eq("/uploads/test/post/logo/#{post.id}/rails.jpg")
    end

    it "saves published at as default if not specified" do
      post = FactoryGirl.create(:post)
      
      expect(post.published_at).to eq(post.created_at)
    end

    it "saves custom published at and does not override it" do
      post = FactoryGirl.create(:post, published_at: "2017-07-01 12:47:52 +0300")

      expect(post.published_at).to eq("2017-07-01 12:47:52 +0300")      
    end

    it "creates an appropriate title transliteration" do
      post = FactoryGirl.create(:post, title: "тестикочевский")
      expect(post.slug).to eq("testikochewskij")
    end
  end
end
