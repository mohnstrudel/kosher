class Front::RecipesController < ApplicationController

  before_action :find_recipe, only: [:show]

  def show
    @status = 200
    begin
      if params[:recipe_category_id].present?
        @recipe = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes.find(params[:id])
      else
        @recipe = Recipe.find(params[:id])
      end
    rescue => e
      @recipe = e.message
      @status = 400
    end

    respond_to do |format|
      format.html
      format.json {
        render json: @recipe, status: @status
      }
    end
  end

  def index
    @status = 200
    begin
      if params[:recipe_category_id].present?
        @recipes = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes
      else
        @recipes = Recipe.all
      end
    rescue => e
      @recipes = e.message
      @status = 400
    end

    respond_to do |format|
      format.html
      format.json {
        render json: @recipes, status: @status
      }
    end
  end

  private

  def find_recipe
    # @recipe = Recipe.find(params[:id])
  end
end
