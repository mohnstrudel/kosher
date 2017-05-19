class Front::PostCategoriesController < ApplicationController
  def index
    @post_categories = PostCategory.all
    respond_to do |format|
      format.html
      format.json {
        render json: @post_categories, status: 200
      }
    end
  end

  def show
    @posts = PostCategory.includes(:posts).find(params[:id]).posts
    respond_to do |format|
      format.html
      format.json {
        render json: @posts, status: 200
      }
    end
  end
end
