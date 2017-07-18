class Front::SuppliersController < FrontController
  def index
    category_id = params[:upper_category]
    subcategory_id = params[:category_id]
    manufacturer_id = params[:manufacturer_id]
    sign_id = params[:sign]

    
    @suppliers = Manufacturer.by_filter(category_id, subcategory_id, manufacturer_id, sign_id)

    p "Inspecting suppliers"
    puts @suppliers.inspect
    puts @suppliers.empty?

    respond_to do |format|
      format.js 
      format.html
    end
  end

  private

  # A list of the param names that can be used for filtering the Product list
  def filtering_params(params)
    params.slice(:category_id)
  end
end
