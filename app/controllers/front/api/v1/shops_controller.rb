module Front
  module Api::V1
    class ShopsController < ApiController

      # GET /v1/events
      def index
        @status = :ok
        begin
          if params[:city_id].present?
            @shops = City.includes(:shops).find(params[:city_id]).shops
          else
            @shops = Shop.all
          end
        rescue => e
          @shops = e.message
          @status = 400
        end

        respond_to do |format|
          format.json {
            render json: @shops, status: @status
          }
        end
      end

      def show
        @status = :ok

        begin
          if params[:city_id].present?
            @shop = City.includes(:shops).find(params[:city_id]).shops.find(params[:id])
          else
            @shop = Shop.find(params[:id])
          end
        rescue => e
          @shop = e.message
          @status = 400
        end

        respond_to do |format|
          format.json {
            render json: @shop, status: @status
            }
        end
      end
    end
  end
end