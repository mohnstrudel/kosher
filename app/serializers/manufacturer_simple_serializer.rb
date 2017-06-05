class ManufacturerSimpleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :parent_id
end
