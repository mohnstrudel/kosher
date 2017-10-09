class FilterManufacturersSerializer < ActiveModel::Serializer
  attributes :id, :title, :categories, :trademarks, :labels

  def trademarks
    object.trademarks.map do |trademark|
      FilterTrademarksSerializer.new(trademark, scope: scope, root: false, trademark: object)
    end
  end

  def categories
    object.parent_categories.map do |category|
      {
        id: category.id,
        title: category.title
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
