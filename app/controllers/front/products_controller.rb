class Front::ProductsController < FrontController

  def index
    # @status = 200
    # if params[:barcode].present?
    #   @products = Product.where(barcode: params[:barcode])
    # elsif (params[:category].present? || params[:manufacturer].present? || params[:label].present?)
    #   cat_id = params[:category]
    #   manu_id = params[:menufacturer]
    #   label_id = params[:label]
    #   begin
    #     @products = Product.includes(:category).includes(:manufacturer).includes(:label).category_scope(cat_id).manufacturer_scope(manu_id).label_scope(label_id)

    #   rescue => e
    #     @products = e.message
    #     @status = 400
    #   end


    # else
    #   begin
    #     @products = Category.includes(:products).find(params[:category_id]).products
    #   rescue
    #     # @products = e.message
    #     # @status = 400
    #     @products = Product.includes(:category).all
    #   end
    # end

    # respond_to do |format|
    #   format.html
    #   format.json {
    #     render json: @products, status: @status
    #   }
    # end
  end

  def show
    # @status = 200
    # begin
    #   if params[:category_id].present?
    #     @product = Category.includes(:products).find(params[:category_id]).products.find(params[:id])
    #   else
    #     @product = Product.find(params[:id])
    #   end
    # rescue => e
    #   @product = e.message
    #   @status = 400
    # end
    
    # respond_to do |format|
    #   format.html
    #   format.json {
    #     render json: @product, status: @status
    #   }
    # end
  end
end
