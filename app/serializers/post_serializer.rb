class PostSerializer < ActiveModel::Serializer
  attributes :id, :slug, :created_at, :updated_at, :post_category, :translations

  def translations
    object.translations.map do |translation| 
      {
        locale: translation.locale,
        title: translation.title,
        body: translation.body
      }
    end 
  end
end
