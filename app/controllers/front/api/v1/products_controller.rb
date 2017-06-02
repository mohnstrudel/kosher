module Front
  module Api::V1
    class ProductsController < ApiController
      
      include ApiConcern

      def index
        index_helper('products', 'categories')
      end

      def show
        show_helper('product', 'categories')
      end
    end
  end
end