module Front
  module Api::V1
    class CategoriesController < ApiController

      include ApiConcern
      
      def index
        index_helper('categories')
      end

      def show
        show_helper('category')
      end
    end
  end
end