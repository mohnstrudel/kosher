class ManufacturerDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :parent_id, :categories

  def categories
    object.categories.uniq.map do |category|
      {
        id: category.id,
        type: category.class.name.downcase,
        attributes: {
          title: category.title,
          description: category.description,
          logo: category.logo,
          parent_id: category.parent_id,
          label_id: category.label_id
        }
      }
    end
  end
end