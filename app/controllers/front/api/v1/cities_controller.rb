module Front
  module Api::V1
    class CitiesController < ApiController

      include ApiConcern
      
      def index
        index_helper('cities')
      end

      def show
        show_helper('city')
      end
    end
  end
end