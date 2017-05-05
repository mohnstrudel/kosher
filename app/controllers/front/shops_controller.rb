class Front::ShopsController < ApplicationController

  def index
    @shops = City.includes(:shops).find(params[:city_id]).shops

    respond_to do |format|
      format.html
      format.json {
        render json: @shops, status: 200
      }
    end
  end

  def show
    @shop = Shop.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        render json: @shop, status: 200
      }
    end
  end
end
