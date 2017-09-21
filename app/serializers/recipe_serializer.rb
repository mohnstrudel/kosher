class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :logo, :description, :category, :ingredients

  def ingredients
    object.recipe_ingredients.map do |recipe_ingredient|
      {
        title: Ingredient.find(recipe_ingredient.ingredient_id).title,
        amount: recipe_ingredient.amount
      }
    end
  end

  def category
    rc = object.recipe_category
    {
      id: rc.try(:id),
      title: rc.try(:title),
      description: rc.try(:description),
      logo: rc.try(:logo)
    }
  end
end
