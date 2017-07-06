class Front::CitiesController < FrontController
  def index
    @cities = City.all
    respond_to do |format|
      format.html
      format.json {
        render json: @cities, status: 200
      }
    end
  end

  def show
    @city = City.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @city, status: 200
      }
    end
  end
end
