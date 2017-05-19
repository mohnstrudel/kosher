class Admin::RecipeCategoriesController < AdminController
  include CrudConcern

  before_action :find_recipe_category, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @recipe_categories = RecipeCategory.all
    @recipe_categories = index_helper("RecipeCategory")
  end

  def new
    @recipe_category = RecipeCategory.new
  end

  def create
    @recipe_category = RecipeCategory.new(recipe_category_params)
    create_helper(@recipe_category, "edit_admin_recipe_category_path")
  end

  def update
    update_helper(@recipe_category, "edit_admin_recipe_category_path", recipe_category_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@recipe_category, "admin_recipe_categories_path")
  end

  private

  def find_recipe_category
    @recipe_category = RecipeCategory.find(params[:id])
  end

  def recipe_category_params
    params.require(:recipe_category).permit(RecipeCategory.attribute_names.map(&:to_sym))
  end

end
