class Front::SuppliersController < FrontController
  def index
    category_id = params[:upper_category]
    subcategory_id = params[:category_id]

    @suppliers = Manufacturer.where(nil)
    filtering_params(params).each do |key, value|
      @suppliers = @suppliers.public_send(key, value) if value.present?
    end

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
