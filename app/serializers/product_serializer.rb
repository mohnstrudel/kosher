class ProductSerializer < ActiveModel::Serializer
  attributes :id, :category, :label, :manufacturer, :title, :description, :logo, :barcode, :created_at
end
