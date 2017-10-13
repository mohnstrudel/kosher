class Front::SuppliersController < FrontController
  def index
    params_array = Array.new
    @filter_items = Array.new
    @category_id = params[:category]
    subcategory_id = params[:subcategory]
    manufacturer_id = params[:manufacturer]
    sign_id = params[:sign]

    if @category_id.present? && @category_id != 'any'
      params_array << Category.friendly.find(@category_id).title
    end
    if subcategory_id.present? && subcategory_id != 'any'
      params_array << Category.friendly.find(subcategory_id).title
    end
    if manufacturer_id.present? && manufacturer_id != 'any'
      params_array << Manufacturer.active.friendly.find(manufacturer_id).title
    end
    if sign_id.present?
      params_array << Label.find(sign_id).title
    end

    @suppliers = Manufacturer.active.by_filter(@category_id, subcategory_id, manufacturer_id, sign_id).uniq.compact
    # populate filter items
    params_array.each do |pa|
      if pa.present?
        @filter_items << pa
      end
    end

  end

  def show
    @supplier = Manufacturer.friendly.find(params[:id])
  end


end
