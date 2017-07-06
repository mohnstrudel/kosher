class Front::RecipesController < FrontController

  before_action :find_recipe, only: [:show]

  def show
    @recipe = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes.find(params[:id])
  end

  def index
    @recipes = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes

  end

  private

  def find_recipe
    # @recipe = Recipe.find(params[:id])
  end
end
