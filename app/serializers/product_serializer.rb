class ProductSerializer < ActiveModel::Serializer
  attributes :id, :label, :manufacturer, :title, :description, :logo, :barcode, :category

  def category
    cat = object.category
    if cat
      {
        id: cat.id,
        title: cat.title,
        logo: cat.logo,
        description: cat.description
      }
    else
      return nil
    end
  end
end
