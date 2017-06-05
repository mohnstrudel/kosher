module Front
  module Api::V1
    class ManufacturersController < ApiController

      include ApiConcern
      
      def index
        index_helper('manufacturers')
      end

      def show
        show_helper('manufacturer')
      end
    end
  end
end