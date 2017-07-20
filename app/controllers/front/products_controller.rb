class Front::ProductsController < FrontController

  def index
    puts "Inspecting params"
    puts params.inspect
    cat_id = params[:category_id]
    manu_id = params[:manufacturer_id]
    keywords = params[:keywords]
    show = params[:incomplete]
    scope = 'all'

    page_size = Rails.application.config.page_size
    
  
    @products = Product.includes(:category).includes(:manufacturer).manufacturer_scope(manu_id).category_scope(cat_id).paginate(:page => params[:page], :per_page => page_size)
  end

  def show
    begin
      @product = Manufacturer.includes(:products).find(params[:supplier_id]).products.find(params[:id])
    rescue ActiveRecord::RecordNotFound => error
      logger.debug error
      @product = Product.find(params[:id])
    end
  end
end
