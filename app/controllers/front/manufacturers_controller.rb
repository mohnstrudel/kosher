class Front::ManufacturersController < FrontController
  def index
    item_amount = Manufacturer.all.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = item_amount / page_size
    if item_amount%page_size != 0
      @pages_total += 1
    end
    @manufacturers = Manufacturer.all
  end
end
