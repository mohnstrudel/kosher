class Front::RestaurantsController < FrontController

  def index
    post_amount = Restaurant.all.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end
    # @cities = City.active_restaurants
    @cities = City.joins(:restaurants).uniq
    begin  
      @restaurants = Restaurant.all.order(sortable: :desc).paginate(page: params[:page], per_page: page_size)
      # @restaurants = City.includes(:restaurants).find(params[:city_id]).restaurants.order(created_at: :desc).paginate(page: params[:page], per_page: page_size)
    rescue RangeError => e
      @restaurants = Restaurant.all.order(sortable: :desc).paginate(page: 1, per_page: page_size)
      logger.debug "Error occured on restaurants_controller. Error message: #{e.message}"
    end
  end

end
