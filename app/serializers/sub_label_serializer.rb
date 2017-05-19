class SubLabelSerializer < ActiveModel::Serializer
  attributes :id, :logo, :title, :description, :created_at, :updated_at
end
