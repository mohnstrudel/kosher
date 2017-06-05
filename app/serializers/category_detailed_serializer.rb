class CategoryDetailedSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :subcategories, :parent_id, :label_id, :manufacturers

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
    object.manufacturers.map do |manufacturer|
      {
        id: manufacturer.id,
        title: manufacturer.title,
        description: manufacturer.description,
        parent_id: manufacturer.parent_id,
        logo: manufacturer.logo
      }
    end
  end
end
