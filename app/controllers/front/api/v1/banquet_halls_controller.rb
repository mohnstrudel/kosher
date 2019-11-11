module Front
  module Api::V1
    class BanquetHallsController < ApiController

      include ApiConcern

      def index
        index_helper('banquet_halls', 'cities')
      end

      def show
        show_helper('banquet_halls', 'cities')
      end
    end
  end
end