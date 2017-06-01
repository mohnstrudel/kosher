module Front
  module Api::V1
    class FaqsController < ApiController

      include ApiConcern
      
      def index
        index_helper('faqs')
      end

      def show
        show_helper('faq')
      end
    end
  end
end