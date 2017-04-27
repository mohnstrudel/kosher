class Front::CategoriesController < FrontController

  def index
    @categories = Category.all

    respond_to do |format|
      format.html
      format.json {
        render json: @categories, status: 200
      }
    end
  end

  def show
    # @products = Category.includes(:products).find(params[:id]).products
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @category, status: 200
      }
    end
  end
end
