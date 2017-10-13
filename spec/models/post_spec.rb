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
      expect(post.slug).to eq("testikochevskiy")
    end
  end

  describe "SEO parameters" do
    it "saves them when creating new post" do
      post = FactoryGirl.build(:post)
      post.build_seo
      post.seo.title = "My SEO title"
      post.seo.keywords = ["hello", "dolly"]

      post.save

      expect(post.seo.title).to eq("My SEO title")
      expect(post.seo.keywords).to eq(["hello", "dolly"])
    end

    it "saves them when editing post" do
      post = FactoryGirl.create(:post)

      post.update(seo_attributes: {title: "Some other title", keywords: ["tag 1", "tag 2"]})

      expect(post.seo.title).to eq("Some other title")
      expect(post.seo.keywords).to eq(["tag 1", "tag 2"])
    end
  end
end
