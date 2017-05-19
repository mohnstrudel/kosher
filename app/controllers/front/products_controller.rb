class Front::ProductsController < FrontController

  def index
    if params[:barcode].present?
      @products = Product.where(barcode: params[:barcode])
    else
      @products = Category.includes(:products).find(params[:category_id]).products
    end

    respond_to do |format|
      format.html
      format.json {
        render json: @products, status: 200
      }
    end
  end

  def show
    
    @product = Product.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json {
        render json: @product, status: 200
      }
    end
  end
end
