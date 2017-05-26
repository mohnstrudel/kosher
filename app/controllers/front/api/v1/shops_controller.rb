module Front
  module Api::V1
    class ShopsController < ApiController

      include ApiConcern

      # GET /v1/events
      def index
        index_helper('shops', 'cities')
      end

      def show
        show_helper('shop', 'cities')
      end
    end
  end
end