class RecipeSimpleSerializer < ActiveModel::Serializer
  attributes :id, :title, :logo, :description, :category


  def category
    RecipeCategorySerializer.new(object.recipe_category, root: false)
  end
end
