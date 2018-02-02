class CategoryDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :subcategories, :parent_id, :label_id, :manufacturers, :labels

  def subcategories
    my_hash = Hash.new
    object.sub_categories.map do |subcategory| 
      {
        id: subcategory.id,
        attributes: {
          title: subcategory.title,
          description: subcategory.description,
          logo: subcategory.logo
        }
        
      }
    end    
  end

  
  def manufacturers
    if object.find_children
      manufs = []
      object.sub_categories.each do |subcat|
        subcat.manufacturers.each do |manufacturer|
          manufs << manufacturer
        end
      end

      manufs.uniq.map do |manufacturer|
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
    else
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
  end

  def labels
    if object.find_children
      labels = Array.new
      
      object.sub_categories.each do |subcat|
        subcat.labels.each do |label|
          labels << label
        end
      end

      labels.uniq.map do |label|
        {
          id: label.id,
          title: label.title
        }
      end
    else
      object.labels.uniq.map do |label|
        {
          id: label.id,
          title: label.title
        }
      end
    end
  end
end
