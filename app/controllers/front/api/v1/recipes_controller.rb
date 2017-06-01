module Front
  module Api::V1
    class RecipesController < ApiController
      
      include ApiConcern

      def index
        index_helper('recipes', 'recipe_categories')
      end

      def show
        show_helper('recipe', 'recipe_categories')
      end
    end
  end
end