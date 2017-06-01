module Front
  module Api::V1
    class RecipeCategoriesController < ApiController
      
      include ApiConcern

      def index
        index_helper('recipe_categories')
      end

      def show
        show_helper('recipe_category')
      end
    end
  end
end