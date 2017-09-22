class PostSerializer < ActiveModel::Serializer
  attributes :id, :slug, :created_at, :translations, :logo, :category

  def category
    # p "object for serializing: #{object.inspect}"
    PostCategorySerializer.new(object.post_category, root: false)
  end

  # belongs_to :post_category, key: "category"
end
