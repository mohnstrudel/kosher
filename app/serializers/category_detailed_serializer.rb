class CategoryDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :subcategories, :parent_id, :label_id, :manufacturers, :labels

  def subcategories
    my_hash = Hash.new
    object.sub_categories.map do |subcategory| 
      {
        id: subcategory.id,
        title: subcategory.title,
        description: subcategory.description,
        logo: subcategory.logo
      }
    end    
  end

  def manufacturers
    object.manufacturers.uniq.map do |manufacturer|
      {
        id: manufacturer.id,
        type: manufacturer.class.name.downcase,
        attributes: {
          title: manufacturer.title,
          description: manufacturer.description,
          logo: manufacturer.logo  
        },
        parent_id: manufacturer.parent_id
        
      }
    end
  end

  def labels
    object.labels.map do |label|
      {
        id: label.id,
        title: label.title
      }
    end
  end
end
