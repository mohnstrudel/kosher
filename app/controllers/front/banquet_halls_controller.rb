class Front::BanquetHallsController < FrontController
  def index
    post_amount = BanquetHall.all.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end
    # @cities = City.active_banquet_halls
    @cities = City.joins(:banquet_halls).order(sortable: :asc).uniq
    begin
      @banquet_halls = BanquetHall.all.order(sortable: :desc).paginate(page: params[:page], per_page: page_size)
      # @banquet_halls = City.includes(:banquet_halls).find(params[:city_id]).banquet_halls.order(created_at: :desc).paginate(page: params[:page], per_page: page_size)
    rescue RangeError => e
      @banquet_halls = BanquetHall.all.order(sortable: :desc).paginate(page: 1, per_page: page_size)
      logger.debug "Error occured on banquet_halls_controller. Error message: #{e.message}"
    end
  end
end
