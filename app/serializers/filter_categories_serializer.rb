class FilterCategoriesSerializer < ActiveModel::Serializer
  attributes :id, :title, :subcategories, :manufacturers, :labels

  def subcategories
    object.sub_categories.map do |subcategory|
      FilterSubcategoriesSerializer.new(subcategory, scope: scope, root: false, category: object)
    end
  end

  def manufacturers
    object.parent_manufacturers.map do |manufacturer|
      {
        id: manufacturer.id,
        title: manufacturer.title
      }
    end
  end

  def labels
    object.parent_labels.map do |label|
      {
        id: label.id,
        title: label.title
      }
    end
  end


  
end
