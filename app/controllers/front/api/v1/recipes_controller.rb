module Front
  module Api::V1
    class RecipesController < ApiController
      
      include ApiConcern

      def index
        # index_helper('recipes', 'recipe_categories')
        @status = :ok
        begin
          if params[:recipe_category_id].present?
            @recipes = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes
          else
            @recipes = Recipe.all
          end
        rescue=>e
          @recipes = e.message
          @status = 400
        end

        respond_to do |format|
          format.json {
            begin
              render json: @recipes, status: @status, each_serializer: "RecipeSimpleSerializer".constantize
            rescue
              render json: @recipes, status: @status
            end
          }
        end
      end

      def show
        @status = :ok

        begin
          if params[:recipe_category_id].present?
            @recipe = RecipeCategory.includes(:recipes).find(params[:recipe_category_id]).recipes.find(params[:id])
          else
            @recipe = Recipe.find(params[:id])
          end
        rescue=>e
          @recipe = e.message
          @status = 400
        end

        respond_to do |format|
          format.json {
            begin
              render json: @recipe, status: @status, serializer: "RecipeDetailedSerializer".constantize
            rescue
              render json: @recipe, status: @status
            end
          }
        end
      end
    end
  end
end