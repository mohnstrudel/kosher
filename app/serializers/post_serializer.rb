class PostSerializer < ActiveModel::Serializer
  attributes :id, :slug, :created_at, :updated_at, :post_category

  has_many :translations
end
