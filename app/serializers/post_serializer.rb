class PostSerializer < ActiveModel::Serializer
  attributes :id, :slug, :created_at, :category, :translations, :logo

  def category
    PostCategorySerializer.new(object.post_category, root: false)
  end

  # def translations
  #   TranslationSerializer.new(object.translations, root: false)
  # end

end
