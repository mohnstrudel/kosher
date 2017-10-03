class Front::CategoriesController < FrontController

  def index
    @categories = Category.top_level
  end

  def show
    @category = Category.find(params[:id])
    @manufacturers = @category.manufacturers
    @category_id = params[:id].to_i
    
  end
end
