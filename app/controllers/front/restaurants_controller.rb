class Front::RestaurantsController < ApplicationController

  def index
    @restaurants = City.includes(:restaurants).find(params[:city_id]).restaurants

    respond_to do |format|
      format.html
      format.json {
        render json: @restaurants, status: 200
      }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @restaurant, status: 200
      }
    end
  end
end
