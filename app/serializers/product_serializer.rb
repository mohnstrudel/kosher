class ProductSerializer < ActiveModel::Serializer
  attributes :id, :label, :manufacturer, :title, :description, :logo, :barcode, :category

  
end
