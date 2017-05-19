class Front::PostsController < ApplicationController

  before_action :find_post, only: [:show]

  def show
    respond_to do |format|
      format.html
      format.json {
        render json: @post, status: 200
      }
    end
  end

  def index
    # @post_category = PageCategory.includes(:posts).find params[:post_category_id]
    # @posts = PostCategory.includes(:posts).find(params[:post_category_id]).posts
    @posts = Post.all

    respond_to do |format|
      format.html
      format.json {
        render json: @posts, status: 200
      }
    end
  end

  private

  def find_post
    @post = Page.find(params[:id])
  end
end
