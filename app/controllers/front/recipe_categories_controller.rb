class Front::RecipeCategoriesController < ApplicationController
  def index
    @recipe_categories = RecipeCategory.all
    respond_to do |format|
      format.html
      format.json {
        render json: @recipe_categories, status: 200
      }
    end
  end

  def show
    @status = 200
    begin
      @category = RecipeCategory.find(params[:id])
    rescue => e
      @category = e.message
      @status = 400
    end
    
    respond_to do |format|
      format.html
      format.json {
        render json: @category, status: @status
      }
    end
  end
end
