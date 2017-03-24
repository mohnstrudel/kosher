class Admin::CategoriesController < AdminController
  
  include CrudConcern

  before_action :find_category, only: [:edit, :update, :destroy]
  before_action :get_locales, only: [:edit, :create, :new]

  def index
    if params[:sublevel]
      @categories = Category.subs
    else
      @categories = Category.top_level
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    create_helper(@category, "edit_admin_category_path")
  end

  def update
    update_helper(@category, "edit_admin_category_path", category_params)
  end

  def edit
  end

  def destroy
    destroy_helper(@category, "admin_categorys_path")
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(Category.attribute_names.map(&:to_sym))
  end

end


