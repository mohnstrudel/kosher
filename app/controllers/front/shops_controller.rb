class Front::ShopsController < FrontController

  def index
    post_amount = Shop.all.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end

    # @cities = City.all
    @cities = City.joins(:shops).uniq
    begin
      @shops = Shop.all.order(sortable: :desc).paginate(page: params[:page], per_page: page_size)
      # @shops = City.includes(:shops).find(params[:city_id]).shops.order(created_at: :desc).paginate(page: params[:page], per_page: page_size)
    rescue RangeError => e
      @shops = Shop.all.order(sortable: :desc).paginate(page: 1, per_page: page_size)
      # @shops = City.includes(:shops).find(params[:city_id]).shops.order(created_at: :desc).paginate(page: 1, per_page: page_size)
      logger.debug "Error occured on shops_controller. Error message: #{e.message}"
    end
  end

  def show

  end
end
