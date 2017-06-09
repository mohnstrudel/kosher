class CategorySimpleSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo, :parent_id, :label_id

end
