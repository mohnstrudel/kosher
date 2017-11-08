class Front::ManufacturersController < FrontController
  def index
    objects = Manufacturer.top_level
    item_amount = objects.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = item_amount / page_size
    if item_amount%page_size != 0
      @pages_total += 1
    end
    @manufacturers = objects.paginate(page: params[:page], per_page: page_size)
  end

  def show
    @manufacturer = Manufacturer.friendly.find(params[:id])
  end
end
