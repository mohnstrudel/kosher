class Admin::IngredientsController < AdminController
  
  include CrudConcern

  before_action :find_ingredient, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    # @ingredients = Ingredient.all
    @ingredients = index_helper("Ingredient")
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    create_helper(@ingredient, "edit_admin_ingredient_path")
  end

  def update
    update_helper(@ingredient, "edit_admin_ingredient_path", ingredient_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@ingredient, "admin_ingredients_path")
  end

  private

  def find_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(Ingredient.attribute_names.map(&:to_sym))
  end

end

