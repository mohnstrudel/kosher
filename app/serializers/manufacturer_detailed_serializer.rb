class ManufacturerDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :parent_id, :categories, :labels

  def categories
    if object.find_children
      categories = Array.new

      object.trademarks.each do |trademark|
        trademark.categories.each do |category|
          categories << category
        end
      end

      categories.uniq.map do |category|
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
    else
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

  def labels
    if object.find_children
      # Если мы именно у производителя
      labels = Array.new

      object.trademarks.each do |trademark|
        trademark.labels.each do |label|
          labels << label
        end
      end

      labels.uniq.map do |label|
        {
          id: label.id,
          title: label.title,
          description: label.description
        }
      end
    else
      # Если мы у торговой марки
      object.labels.uniq.map do |label|
        {
          id: label.id,
          title: label.title,
          description: label.description
        }
      end
    end
  end
end