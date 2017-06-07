class PostSerializer < ActiveModel::Serializer
  attributes :id, :slug, :created_at, :category, :translations, :logo

  def category
    cat = object.post_category 
    if cat
      { 
        id: cat.id, 
        title: cat.title
      }
    else
      return nil
    end
  end

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
