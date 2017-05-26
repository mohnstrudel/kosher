class RecipeCategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :logo
end
