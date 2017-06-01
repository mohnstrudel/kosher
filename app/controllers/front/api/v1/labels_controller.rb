module Front
  module Api::V1
    class LabelsController < ApiController

      include ApiConcern
      
      def index
        index_helper('labels')
      end

      def show
        show_helper('label')
      end
    end
  end
end