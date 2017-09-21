module Front
  module Api::V1
    class ProductsController < ApiController
      
      include ApiConcern

      def index
        @status = :ok
        # index_helper('products', 'categories')

        if params[:barcode].present?
          @products = Product.includes(:category).includes(:manufacturer).includes(:label).where(barcode: params[:barcode])
        elsif (params[:category].present? || params[:manufacturer].present? || params[:label].present?)
          
          cat_id = params[:category]
          manu_id = params[:manufacturer]
          label_id = params[:label]

          begin
            @products = Product.includes(:category).includes(:manufacturer).includes(:label).category_scope(cat_id).manufacturer_scope(manu_id).label_scope(label_id)
          rescue => e
            @products = "Errors encountered on Products API index page. Error message: #{e.message}"
            @status = 400
          end
        else
          @products = Product.includes(:category).includes(:manufacturer).includes(:label).all
        end
        
        respond_to do |format|
          format.json { render json: @products, status: @status }
        end
      end

      def show
        show_helper('product', 'categories')
      end
    end
  end
end