class Front::RecipesController < FrontController

  before_action :find_recipe, only: [:show]

  def show
    @recipe = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes.includes(:ingredients).find(params[:id])
  end

  def index
    @recipes = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes.includes(:ingredients)
    post_amount = @recipes.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end

  end

  private

  def find_recipe
    # @recipe = Recipe.find(params[:id])
  end
end
