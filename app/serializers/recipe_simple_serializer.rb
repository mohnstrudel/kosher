class RecipeSimpleSerializer < ActiveModel::Serializer
  attributes :id, :title, :logo, :description, :category

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
