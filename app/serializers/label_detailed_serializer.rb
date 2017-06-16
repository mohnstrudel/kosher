class LabelDetailedSerializer < ActiveModel::Serializer
  attributes :id, :logo, :title, :description, :sublabels, :products

  def products
    object.products.map do |product|
      {
        id: product.id,
        title: product.title,
        category: product.category.title
      }
    end
  end

  def sublabels
    object.sub_labels.map do |sub_label| 
      {
        id: sub_label.id,
        attributes: {
          title: sub_label.title,
          logo: sub_label.logo
        }
      }
    end    
  end

  # def sub_labels
  #   object.sub_labels.pluck(:id, :title, :logo)
  # end
end
