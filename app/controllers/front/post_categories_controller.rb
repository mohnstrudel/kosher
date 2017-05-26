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
    @post_category = PostCategory.includes(:posts).find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @post_category, status: 200
      }
    end
  end
end
