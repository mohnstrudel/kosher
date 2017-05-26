class Front::PostsController < ApplicationController

  before_action :find_post, only: [:show]

  def show
    @status = 200
    begin
      category = PostCategory.find(params[:post_category_id])
      @post = Post.where(post_category_id: category.id).find(params[:id])
    rescue => e
      @post = e.message
      @status = 400
    end
    respond_to do |format|
      format.html
      format.json {
        render json: @post, status: @status
      }
    end
  end

  def index
    @status = 200
    # @post_category = PageCategory.includes(:posts).find params[:post_category_id]
    begin
      @posts = PostCategory.includes(:posts).find(params[:post_category_id]).posts
    rescue => e
      @posts = e
      @status = 400
    end
    # @posts = Post.all

    respond_to do |format|
      format.html
      format.json {
        render json: @posts, status: @status
      }
    end
  end

  private

  def find_post
    # @post = Page.find(params[:id])
  end
end
