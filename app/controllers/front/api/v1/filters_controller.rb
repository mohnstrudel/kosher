module Front
  module Api::V1
    class FiltersController < ApiController
      
      def categories
        # @categories = Category.all.pluck(:id, :title).map { |id, title| {id: id, title: title}}
        # @categories = Category.all.as_json(only: [:id, :title])
        # @categories = Category.select(:id, :title).each_hash.lazy.map(&:values)


        @categories = Category.top_level.select(:id,:title,:parent_id)
        render json: @categories, each_serializer: FilterCategoriesSerializer
      end

      def manufacturers

        @manufacturers = Manufacturer.top_level.select(:id, :title, :parent_id)
        render json: @manufacturers, each_serializer: FilterManufacturersSerializer
        
      end
    end
  end
end