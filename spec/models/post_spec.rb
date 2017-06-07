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

      expect(post.logo.url).to eq("/uploads/post/logo/1/rails.jpg")
    end
  end
end
