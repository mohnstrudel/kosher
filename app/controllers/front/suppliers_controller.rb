class Front::SuppliersController < FrontController
  def index
    category_id = params[:upper_category]
    subcategory_id = params[:category_id]
    manufacturer_id = params[:manufacturer_id]
    sign_id = params[:sign]

    @suppliers = Manufacturer.by_filter(category_id, subcategory_id, manufacturer_id, sign_id).uniq.compact
  end

  def show
    @supplier = Manufacturer.find(params[:id])
  end


end
