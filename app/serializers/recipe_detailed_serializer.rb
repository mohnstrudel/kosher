class RecipeDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :logo, :description, :category, :ingredients

  def ingredients
    Recipe.includes(:ingredients).includes(:recipe_ingredients).find(object.id).recipe_ingredients.map do |recipe_ingredient|
      {
        title: recipe_ingredient.ingredient.title,
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
