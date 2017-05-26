module Front
  module Api::V1
    class RestaurantsController < ApiController
      
      include ApiConcern

      def index
        index_helper('restaurants')
      end

      def show
        show_helper('restaurant')
      end
    end
  end
end