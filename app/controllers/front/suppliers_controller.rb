class Front::SuppliersController < FrontController
  def index
    params_array = Array.new
    @filter_items = Array.new
    @category_id = params[:category]
    subcategory_id = params[:subcategory]
    manufacturer_id = params[:manufacturer]
    sign_ids = params[:label_ids]

    if @category_id.present? && @category_id != 'any'
      params_array << Category.friendly.find(@category_id).title
    else
      params_array << Category.all
    end
    if subcategory_id.present? && subcategory_id != 'any'
      params_array << Category.friendly.find(subcategory_id).title
    else
      params_array << Category.all
    end
    if manufacturer_id.present? && manufacturer_id != 'any'
      params_array << Manufacturer.active.friendly.find(manufacturer_id).title
    else
      params_array << Manufacturer.all
    end
    if sign_ids.present?
      sign_ids.each do |sign_id|
        params_array << Label.find(sign_id).title
      end
    end

    @suppliers = Manufacturer.active.by_filter(@category_id, subcategory_id, manufacturer_id, sign_ids).uniq.compact
    logger.debug("Calling filter with params: category - #{@category_id}, subcategory - #{subcategory_id} and manufacturer - #{manufacturer_id}")
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
