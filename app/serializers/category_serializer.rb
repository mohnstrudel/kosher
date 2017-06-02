class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :subcategories, :parent_id, :label_id

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
end
