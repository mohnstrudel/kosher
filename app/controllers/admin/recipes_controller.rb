class Admin::RecipesController < AdminController
  
  include CrudConcern

  before_action :find_recipe, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @recipes = Recipe.all
    @recipes = index_helper("Recipe")
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    @recipe.build_seo
  end

  def create
    @recipe = Recipe.new(recipe_params)
    create_helper(@recipe, "edit_admin_recipe_path")
  end

  def update
    update_helper(@recipe, "edit_admin_recipe_path", recipe_params)
  end

  def edit
    if @recipe.recipe_ingredients.blank?
      @recipe.recipe_ingredients.build
    end

    if @recipe.seo.blank?
      @recipe.build_seo
    end
  end

  def destroy
    destroy_helper(@recipe, "admin_recipes_path")
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(Recipe.attribute_names.map(&:to_sym).push(
      recipe_ingredients_attributes: [:id, :amount, :recipe_id, :ingredient_id, :_destroy]).push(
      seo_attributes: [:id, :title, :description, :image, keywords: [] ]))
  end

end
