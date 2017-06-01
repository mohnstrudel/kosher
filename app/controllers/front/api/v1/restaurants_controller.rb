module Front
  module Api::V1
    class RestaurantsController < ApiController
      
      include ApiConcern

      def index
        index_helper('restaurants', 'cities')
      end

      def show
        show_helper('restaurant', 'cities')
      end
    end
  end
end