class Front::RecipesController < ApplicationController

  before_action :find_recipe, only: [:show]

  def show

  end

  def index

  end

  private

  def find_recipe
    # @recipe = Recipe.find(params[:id])
  end
end
