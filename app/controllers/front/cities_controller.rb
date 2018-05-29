class Front::CitiesController < FrontController
  def index

    if params[:shop_id].present?
      @city = City.includes(:shops).friendly.find(params[:shop_id])
      @objects = @city.shops.order(sortable: :asc)
      @type = "магазины"
    elsif params[:restaurant_id].present?
      @city = City.includes(:restaurants).friendly.find(params[:restaurant_id])
      @objects = @city.restaurants.order(sortable: :asc)
      @type = "рестораны"
    end

    post_amount = @objects.count
    page_size = Rails.application.config.page_size
    @page = (params[:page] || 1).to_i
    @pages_total = post_amount / page_size
    if post_amount%page_size != 0
      @pages_total += 1
    end

    respond_to do |format|
      format.html
    end
    
    
  end

  # def show
  #   @city = City.find(params[:id])
  #   respond_to do |format|
  #     format.html
  #     format.json {
  #       render json: @city, status: 200
  #     }
  #   end
  # end
end
